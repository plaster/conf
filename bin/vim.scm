#!/usr/bin/env gosh
(use gauche.interactive)
(use util.match)

(print "\"Generated file. Any change will be discarded.")

(define (parse-line line)
  (match (port->sexp-list (open-input-string line))
    [ (y (m)) (values (symbol->string y) y m) ]
    [else
      (errorf "unknown output: ~s" line)
      ]
    ))

(define (emit-line s y m)
  (let1 v (eval y (find-module m))
    (and
      (rxmatch-case s
        [ #/ / () #f ]
        [ #/^let/ () #t ]
        [ #/-let1$/ () #t ]
        [ #/^define/ () #t ]
        [ #/-let1$/ () #t ]
        [ #/-case$/ () #t ]
        [ #/-with-/ () #t ]
        [ #/-lambda$/ () #t]
        [else #f]
        )
      (print "set lw+=" y)
      )

    (cond
      [ (#/ / s)
        ;; do nothing
        ]
      [ (procedure? v)
       (format #t "syn keyword schemeExtFunc ~a~%" y)
       ]
      [ (or (is-a? v <macro>)
            (is-a? v <syntax>))
       (format #t "syn keyword schemeExtSyntax ~a~%" y)
       ]
      [else
        (format #t "syn keyword schemeExtSyntax ~a~%" y)
        ]
      )))

(call-with-input-string
  (with-output-to-string (cut apropos #// 'gauche))
  (^ (iport)
     (port-for-each (.$ emit-line parse-line) (cut read-line iport))
     ))
