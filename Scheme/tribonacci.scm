;; INPUT
(define solve-aux
  (lambda (input-file)
    (cond ((eof-object? (peek-char input-file)) (display ""))
          ((not (equal? (char->integer (peek-char input-file)) 0))
           (display (tribonacci (string->number (read-line input-file))))
           (display "\n")
           (solve-aux input-file))
          (#t (display "")))))
(define solve
  (lambda (file)
    (solve-aux (open-input-file file))))

;; Tribonacci
(define modtrb
  (lambda (v)
    (remainder v 1000000009)))
(define prod-pto
  (lambda (v w)
    (modtrb (apply + (map (lambda (a) (modtrb a)) (map (lambda (a b) (modtrb (* (modtrb a) (modtrb b)))) v w))))))


(define transpuesta
  (lambda (mat)
    (cond ((null? mat) '())
          ((null? (car mat)) '())
          (else (cons (map car mat) (transpuesta (map cdr mat)))))))

(define mul-mat
  (lambda (m1 m2)
    (map (lambda (fila)
           (map (lambda (columna) (prod-pto fila columna))
                (transpuesta m2)))
           m1)))

(define repetir
  (lambda (e n)
    (cond ((zero? n) '())
          (else (cons e (repetir e (- n 1)))))))

(define identidad
  (lambda (n)
    (cond ((zero? n) '())
          (else (cons (cons 1 (repetir 0 (- n 1)))
                      (map (lambda (fila) (cons 0 fila)) (identidad (- n 1))))))))

(define cuad-mat
  (lambda (m)
    (mul-mat m m)))

(define elevar-mat
  (lambda (mat n)
    (cond ((zero? n) (identidad (length mat)))
          ((even? n) (cuad-mat (elevar-mat mat (quotient n 2))))
          (else (mul-mat mat (cuad-mat (elevar-mat mat (quotient n 2))))))))  ;;odd?

(define tribonacci
  (lambda (n)
    (cadr (cadr (elevar-mat '((0 1 0) (0 0 1) (1 1 1)) n)))))

(define nada
  (lambda (n)
    0))
