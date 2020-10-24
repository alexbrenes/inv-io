;; S: 2, D: 0

;; Case #1: 100
;; (dijkstra '((0 1 100) (1 0 100)) 0 1 2)
;; Case #2: 150
;; (dijkstra '((0 1 100) (0 2 200) (1 0 100) (1 2 50) (2 0 200) (2 1 50)) 2 0 3)
;; Case #3: unreachable
;; (dijkstra '() 0 1 2)
;; Case #4
;; (dijkstra '((0 1 4) (1 0 4) (0 2 2) (2 0 2) (1 2 1) (2 1 1) (1 3 5) (3 1 5) (2 3 8) (3 2 8) (2 4 10) (4 2 10) (3 4 2) (4 3 2) (3 5 6) (5 3 6) (4 5 3) (5 4 3)) 5 2 6)
;; Case #5
;; (dijkstra '())

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
          (#t (remplazar-dist (replace-at Dist (+ (element-at Dist (cadar Q)) (caddar V)) (caar V)) (cdr V) Q PA)))))

(define dijkstra-aux
  (lambda (Q Dist G S D N)
    (cond ((null? Q) (element-at Dist D))
          ((equal? (cdar Q) D) (element-at Dist D))
          (#t (dijkstra-aux (insertarV (cdr Q) (filter (lambda (a) (< (+ (caddr a) (element-at Dist (cadar Q))) (element-at Dist (car a)))) (vecinos-de (cadar Q) G)))
                            (remplazar-dist Dist (filter (lambda (a) (< (+ (caddr a) (element-at Dist (cadar Q))) (element-at Dist (car a)))) (vecinos-de (cadar Q) G)) Q (caar Q))
                            G S D N)))))

(define dijkstra
  (lambda (G S D N)
    (cond ((null? G) 1073741824)
          (#t (dijkstra-aux (list (append (list 0) (list S))) (distancias N S) G S D N)))))


(define print
  (lambda (V Case)
    (display "Case #")
    (display Case)
    (display ": ")
    (display (cond ((= V 1073741824) "unreachable")
                                                                    (#t V)))
    (display "\n")))

(define solve-aux
  (lambda (file)
    (tcase (string->number (read-line file)) 1 file)))

(define tcase-aux
  (lambda (TC file)
    (ttcase (read file) (read file) (read file) (read file) TC file)))

(define edges
  (lambda (A file)
    (cond ((= A 0) '())
          (#t (append (list (append (list (read file)) (list (read file)) (list (read file)))) (edges (- A 1) file))))))

(define ttcase
  (lambda (N A S D TC file)
    (print (dijkstra (r-edge (edges A file)) S D N) TC)))

(define tcase
  (lambda (T TC file)
    (cond ((= T 1) (tcase-aux TC file))
          (#t (tcase-aux TC file)
              (tcase (- T 1) (+ TC 1) file)))))

(define solve
  (lambda (file)
    (solve-aux (open-input-file file))))
(solve "se.txt")
;; (print (dijkstra '((0 1 4) (1 0 4) (0 2 2) (2 0 2) (1 2 1) (2 1 1) (1 3 5) (3 1 5) (2 3 8) (3 2 8) (2 4 10) (4 2 10) (3 4 2) (4 3 2) (3 5 6) (5 3 6) (4 5 3) (5 4 3)) 5 2 6) 1)
;; (print (dijkstra (r-edge '((0 1 50) (2 1 70) (0 2 150))) 0 2 6) 1)
;; (print (dijkstra (r-edge '((1 0 10000))) 0 1 2) 1)
;; (print (dijkstra '((0 1 100) (1 0 100)) 0 2 3) 1)
;; (print (dijkstra '((0 1 100) (0 2 200) (1 0 100) (1 2 50) (2 0 200) (2 1 50)) 2 0 3) 1)
;; (print (dijkstra '() 0 1 2) 1)
;; (print (dijkstra (r-edge '((0 1 123) (1 2 467) (2 3 478) (4 5 578) (5 3 47) (2 6 256) (7 2 246) (5 9 245) (5 3 1245) (8 2 575) (9 4 235) (2 8 437) (9 12 367) (13 7 587) (11 9 476) (9 5 34) (11 13 35) (13 10 2) (12 11 7) (12 6 235))) 13 2 14) 1)