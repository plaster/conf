(use gauche.interactive)
(use util.match)

(print "\"Generated file. Any change will be discarded.")
(print "se lisp expandtab")

(define (parse-line line)
  (match (port->sexp-list (open-input-string line))
    [ (s (m)) (values s m) ]
    [else
      (errorf "unknown output: ~s" line)
      ]
    ))

(define (emit-line s m)
  (let1 v (eval s (find-module m))
    (if (procedure? v)
      (format #t "syn keyword schemeExtFunc ~a~%" s)
      (format #t "syn keyword schemeExtSyntax ~a~%" s)
      )))

(call-with-input-string
  (with-output-to-string (cut apropos #// 'gauche))
  (^ (iport)
     (port-for-each (.$ emit-line parse-line) (cut read-line iport))
     ))
