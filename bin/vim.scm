#!/usr/bin/env gosh
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
    #/^% /
    ))

(define exclude-module-name-table (alist->hash-table (map (cut cons <> #t) *exclude-module-name-list*) 'eq?))

(define exclude-binding-table (alist->hash-table (map (cut cons <> #t) *exclude-binding-list*) 'eq?))

(define (exclude-module-name? mn)
  (or
    (hash-table-exists? exclude-module-name-table mn)
    (let1 mn-s (symbol->string mn)
      (let loop [[ pat-list *exclude-module-name-pat-list* ]]
        (match pat-list
          [ () #f ]
          [ (pat . pat-list)
           (or (pat mn-s)
               (loop pat-list))
           ]
          )))))

(define (exclude-binding? y)
  (or
    (hash-table-exists? exclude-binding-table y)
    (let1 mn-s (symbol->string y)
      (let loop [[ pat-list *exclude-binding-pat-list* ]]
        (match pat-list
          [ () #f ]
          [ (pat . pat-list)
           (or (pat mn-s)
               (loop pat-list))
           ]
          )))))


(print "\"Generated file. Any change will be discarded.")

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
               [else #f]
               ) ]
          [ v (eval y (find-module m)) ]
          ]
      (let [[ kw-type
              (cond
                [ (procedure? v)
                 'schemeExtFunc
                 ]
                [ (or (is-a? v <macro>)
                      (is-a? v <syntax>))
                 'schemeExtSyntax
                 ]
                [else
                  'schemeExtSyntax
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
       [ emit-lw (^ (y)
                 (and (hash-table-get lw?-table y)
                      (print "set lw+=" y)
                      )
                 ) ]
       [ emit-kw (^ (y)
                 (if-let1 kw-type (hash-table-get kw-type-table y)
                   (print "syn keyword " kw-type " " y)
                   )
                 ) ]
       ]
  (display "loading " (current-error-port))
  (for-each (^ (mn)
               (display "o" (current-error-port))
               (eval `(require ,(module-name->path mn))
                     (find-module 'gauche))
               (call-with-input-string
                 (with-output-to-string
                   (^ () (apropos #// mn)))
                 (^ (iport)
                    (port-for-each (.$ store! lw?+kw-type parse-line) (cut read-line iport))
                    ))
               )
            all-module-names)

  (newline (current-error-port))
  (display "emitting " (current-error-port))
  (for-each emit-lw (sort (hash-table-keys kw-type-table)))
  (for-each emit-kw (sort (hash-table-keys kw-type-table)))
  (newline (current-error-port))
  )
