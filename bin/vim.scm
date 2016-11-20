#!/usr/bin/env gosh

;                                    CC0
;
; To the extent possible under law, Haruka Kai has waived all copyright and
; related or neighboring rights to this syntax file generator.
; This work is published from: Japan.
;
; https://creativecommons.org/publicdomain/zero/1.0/deed


(use gauche.interactive)
(use util.match)

(define *exclude-module-name-list*
  '( slib
     text.info
     gauche.singleton
     gauche.let-opt
     gauche.validator
     ))
(define *exclude-module-name-pat-list*
  '( #/^srfi\./
     #/^compat\./
    ))

(define *exclude-binding-list*
  '( info
     info-page
     make-car-comparator make-cdr-comparator
     dbd-null-test-result-set!
     ))
(define *exclude-binding-pat-list*
  '(
    #/ /
    #/^%/
    ))

(define *headertext* #`"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"
 GENERATED FILE. ANY CHANGE WILL BE DISCARDED.

 Generator: https://github.com/plaster/conf/blob/master/bin/vim.scm
 Environment:
  (gauche-version) ==> ,(gauche-version)
  (now) ==> ,($ sys-strftime \"%Y-%m-%d %H:%M:%S\" $ sys-localtime $ sys-time)

\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\""
)

(define %list->eq-set (.$ (cut alist->hash-table <> 'eq?)
                          (map$ (cut cons <> #t)) ))

(define (%eq-set+rx-list->pred table pat-list)
  (^y (or (hash-table-exists? table y)
          (let1 s (symbol->string y)
            (let loop [[pat-list pat-list]]
              (match pat-list
                [ () #f ]
                [ (pat . pat-list)
                 (or (pat s)
                     (loop pat-list)) ]
                ))))))

(define exclude-module-name?
  (%eq-set+rx-list->pred (%list->eq-set *exclude-module-name-list*)
                         *exclude-module-name-pat-list*) )

(define exclude-binding?
  (%eq-set+rx-list->pred (%list->eq-set *exclude-binding-list*)
                         *exclude-binding-pat-list*) )

(define (parse-line line)
  (match (port->sexp-list (open-input-string line))
    [ (y (m)) (values (symbol->string y) y m) ]
    [else
      (errorf "unknown output: ~s" line)
      ]
    ))

(define (lw?+kw-type s y m)
  (if (exclude-binding? y)
    (values y #f #f)
    (let [[ lw?
            (rxmatch-case s
               [ #/^let/ () #t ]
               [ #/-let$/ () #t ]
               [ #/-letrec$/ () #t ]
               [ #/-let\*$/ () #t ]
               [ #/-let1$/ () #t ]
               [ #/glet\*$/ () #t ]
               [ #/glet1$/ () #t ]
               [ #/^define/ () #t ]
               [ #/-if$/ () #t ]
               [ #/rxmatch-case$/ () #t ]
               [ #/-with-/ () #t ]
               [ #/-lambda$/ () #t]
               [ #/^match$/ () #t]
               [else #f]
               ) ]
          [ v (eval y (find-module m)) ]
          ]
      (let [[ kw-type
              (cond
                [ (procedure? v)
                 'schemeFunc
                 ]
                [ (or (is-a? v <macro>)
                      (is-a? v <syntax>))
                 'schemeSyntax
                 ]
                [else
                  'schemeSyntax
                  ]
                ) ]
            ]
        (values y lw? kw-type)
        ))))

(let* [[ all-module-names (append-map (cute library-fold <>
                                            (^ (mn path mns)
                                               (if (exclude-module-name? mn) mns (cons mn mns))
                                               )
                                            '() )
                                      '( *
                                         *.*
                                         ) ) ]
       [ lw?-table (make-hash-table 'eq?) ]
       [ kw-type-table (make-hash-table 'eq?) ]
       [ store! (^ (y lw? kw-type)
                   (hash-table-put! lw?-table y lw?)
                   (hash-table-put! kw-type-table y kw-type)
                   (display "." (current-error-port))
                   ) ]
       [ exported?$ (^ (mn)
                       (match ($ module-exports $ find-module mn)
                         [ #t (^_ #t) ]
                         [ (and (? pair? ) exl)
                          (pa$ hash-table-exists?
                               (%list->eq-set exl))
                          ]
                         [ else (^_ #f) ]
                         )) ]

       [ store!$ (^ (mn)
                    (let1 exported? (exported?$ mn)
                      (^ (y lw? kw-type)
                         (and (exported? y)
                              (store! y lw? kw-type))))) ]
       [ emit-lw (^ (y)
                 (and (hash-table-exists? lw?-table y)
                      (hash-table-get lw?-table y)
                      (print "set lw+=" y)
                      )
                 ) ]
       [ emit-kw (^ (y)
                 (if-let1 kw-type (and (hash-table-exists? kw-type-table y)
                                       (hash-table-get kw-type-table y) )
                   (print "syn keyword " kw-type " " y)
                   )
                 ) ]
       ]
  (display "loading " (current-error-port))
  (for-each (^ (mn)
               (display "o" (current-error-port))
               (eval `(require ,(module-name->path mn))
                     (find-module 'gauche))
               (let1 store! (store!$ mn)
                 (call-with-input-string
                   (with-output-to-string
                     (^ () (apropos #// mn)))
                   (^ (iport)
                      (port-for-each
                        (.$ store! lw?+kw-type parse-line)
                        (cut read-line iport))
                      ))
                 ) )
            all-module-names)

  (for-each (^ (mn) (hash-table-put! kw-type-table mn 'schemeExtSyntax) )
            all-module-names)

  (newline (current-error-port))
  (display "emitting " (current-error-port))
  ($ for-each (pa$ print "\"")
     $ string-split *headertext* #\newline
     )
  (for-each emit-lw (sort (hash-table-keys kw-type-table)))
  (for-each emit-kw (sort (hash-table-keys kw-type-table)))
  (newline (current-error-port))
  )
