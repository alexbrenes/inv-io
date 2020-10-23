;; PRINT
(define print
  (lambda (l)
    (cond ((null? (cdr l)) (display (car l))
                           (display #\newline))
          (#t (display (car l))
              (display ", ")
              (print (cdr l))))))
;; INPUT
;; COMBINACIONES
(define combination-aux
  (lambda (k l cl)
    (cond ((= k (length cl)) (list cl))
          ((null? l) l)
          (#t (append (combination-aux k (cdr l) (append cl (list (car l)))) (combination-aux k (cdr l) cl))))))
(define combination
  (lambda (k l)
    (cond ((null? l) l)
          ((< (length l) k) '())
          ((= (length l) k) (list l))
          (#t (combination-aux k l '())))))
;; CASO A B
(define bundling-ab
  (lambda (a b l)
    (display (string-append "Size " (number->string a)))
    (display #\newline)
    (cond ((= a b) (for-each print (combination b l))
                   (display #\newline))
          (#t (for-each print (combination a l))
              (display #\newline)
              (bundling-ab (+ a 1) b l)))))
;; CASO *
(define bundling-every
  (lambda (l) (bundling-ab 1 (length l) l)))
;; CASO A
(define bundling-A
  (lambda (a l) (display (string-append "Size " (number->string a)))
    (display #\newline)
    (for-each print (combination a l))
    (display #\newline)))