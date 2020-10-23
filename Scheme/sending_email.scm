;; S: 2, D: 0

;; '(((1 100) (2 200)) ((0 100) (2 50)) ((0 200) (1 50)))

;; '((0 1 100) (0 2 200) (1 0 100) (1 2 50) (2 0 200) (2 1 50))

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

(define insertarOrd
  (lambda (Q E)
    (cond ((null? Q) (list (append (list (car E)) (list (caddr E)))))
          ((< (caddr E) (cadar Q)) (append (list (append (list (car E)) (list (caddr E)))) Q))
          (#t (append (list (car Q)) (insertarOrd (cdr Q) E))))))

(define element-at
  (lambda (L N)
    (cond ((= N 0) (car L))
          (#t (element-at (cdr L) (- N 1))))))

;; Remplazar valores en Dist
(define remplazar-dist
  (lambda (Dist V)
    (cond ((null? V) Dist)
          (#t (remplazar-dist (replace-at Dist (+ (element-at Dist (caar V)) (caddar V)) (caar V)) (cdr V))))))

(define dijkstra-aux
  (lambda (Q Dist G S D N)
    (cond ((null? Q) (element-at Dist D))
          ((equal? (cadar Q) D) (element-at Dist D))
          (#t (filter (lambda (a) (< (+ (caddr a) (cadar Q)) (element-at Dist (car a)))) (vecinos-de (cadar Q) G))))))

(define dijkstra
  (lambda (G S D N)
         (dijkstra-aux (list (append (list 0) (list S))) (distancias N S) G S D N)))

(dijkstra '((0 1 100) (0 2 200) (1 0 100) (1 2 50) (2 0 200) (2 1 50)) 2 0 3)