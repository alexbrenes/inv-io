;; S: 2, D: 0

;; Case #1: 100
;; (dijkstra '((0 1 100) (1 0 100)) 0 1 2)
;; Case #2: 150
;; (dijkstra '((0 1 100) (0 2 200) (1 0 100) (1 2 50) (2 0 200) (2 1 50)) 2 0 3)
;; Case #3: unreachable
;; (dijkstra '() 0 1 2)
;; Case #4
;; (dijkstra '((0 1 4) (1 0 4) (0 2 2) (2 0 2) (1 2 1) (2 1 1) (1 3 5) (3 1 5) (2 3 8) (3 2 8) (2 4 10) (4 2 10) (3 4 2) (4 3 2) (3 5 6) (5 3 6) (4 5 3) (5 4 3)) 5 2 6)


(define r-edge
  (lambda (G)
    (cond ((null? G) '())
          (#t (append (list (car G)) (list (append (list (cadar G)) (list (caar G)) (list (caddar G)))) (r-edge (cdr G)))))))

(define repeat-e
  (lambda (E N)
    (cond ((<= N 0) '())
          (#t (append (list E) (repeat-e E (- N 1)))))))

(define replace-at
  (lambda (L E N)
    (cond ((= N 0) (append (list E) (cdr L)))
          (#t (append (list (car L)) (replace-at (cdr L) E (- N 1)))))))

(define vecinos-de
  (lambda (N G)
    (filter (lambda (a) (cond ((equal? N (cadr a)) #t)
                              (#t #f))) G)))
;; Distancias

(define distancias
  (lambda (N I) (append (repeat-e 1073741824 I) (list 0) (repeat-e 1073741824 (- N (+ I 1))))))

;;(W I)

(define insertarV
  (lambda (Q V)
    (cond ((null? V) Q)
          (#t (insertarV (insertarOrd Q (car V)) (cdr V))))))

(define insertarOrd
  (lambda (Q E)
    (cond ((null? Q) (list (append (list (caddr E)) (list (car E)))))
          ((< (caddr E) (caar Q)) (append (list (append (list (caddr E)) (list (car E)))) Q))
          (#t (append (list (car Q)) (insertarOrd (cdr Q) E))))))

(define element-at
  (lambda (L N)
    (cond ((= N 0) (car L))
          (#t (element-at (cdr L) (- N 1))))))

;; Remplazar valores en Dist
(define remplazar-dist
  (lambda (Dist V Q PA)
    (cond ((null? V) Dist)
          (#t (remplazar-dist (replace-at Dist (+ (caar Q) (caddar V)) (caar V)) (cdr V) Q PA)))))

(define dijkstra-aux
  (lambda (Q Dist G S D N)
    (cond ((null? Q) (element-at Dist D))
          ((equal? (cdar Q) D) (element-at Dist D))
          (#t (dijkstra-aux (insertarV '() (filter (lambda (a) (< (+ (caddr a) (caar Q)) (element-at Dist (car a)))) (vecinos-de (cadar Q) G)))
                            (remplazar-dist Dist (filter (lambda (a) (< (+ (caddr a) (caar Q)) (element-at Dist (car a)))) (vecinos-de (cadar Q) G)) Q (caar Q))
                            G S D N)))))

(define dijkstra
  (lambda (G S D N)
    (cond ((null? G) 1073741824)
          (#t (dijkstra-aux (list (append (list 0) (list S))) (distancias N S) G S D N)))))


(define print
  (lambda (V Case)
    (display "Case #") (display Case) (display ": ") (display (cond ((= V 1073741824) "unreachable")
                                                                    (#t V)))))

(define solve-aux
  (lambda (input-file)
    (tcase (string->number (read-line input-file)) file)))

(define tcase
  (lambda (T file)
    (cond ((= T 1) (tcase-aux file))
          (#t (tcase (- T 1) )))))

(define solve
  (lambda (file)
    (solve-aux (open-input-file file))))
(print (dijkstra '((0 1 4) (1 0 4) (0 2 2) (2 0 2) (1 2 1) (2 1 1) (1 3 5) (3 1 5) (2 3 8) (3 2 8) (2 4 10) (4 2 10) (3 4 2) (4 3 2) (3 5 6) (5 3 6) (4 5 3) (5 4 3)) 5 2 6) 1)

;; (print (dijkstra '((0 1 100) (1 0 100)) 0 2 3) 1)
;; (print (dijkstra '((0 1 100) (0 2 200) (1 0 100) (1 2 50) (2 0 200) (2 1 50)) 2 0 3) 1)
;; (print (dijkstra '() 0 1 2) 1)