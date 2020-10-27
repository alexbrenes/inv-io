elems(0,_,[]):-!.
elems(1,E,[E]):-!.
elems(N,E,R):- N1 is N-1,elems(N1,E,R1), R = [E|R1].

modTrb(V,R) :- R is V rem 1000000009.

transpose([], []).
transpose([F|Fs], Ts) :- transpose(F, [F|Fs], Ts).

transpose([], _, []).
transpose([_|Rs], Ms, [Ts|Tss]) :- lists_firsts_rests(Ms, Ts, Ms1), transpose(Rs, Ms1, Tss).

lists_firsts_rests([], [], []).
lists_firsts_rests([[F|Os]|Rest], [F|Fs], [Os|Oss]) :- lists_firsts_rests(Rest, Fs, Oss).
		

idAux(L,R,Res):- elems(L,0,L1), elems(R,0,R1),append(L1,[1],Res1),append(Res1,R1,Res).

id(N,0,N,Res):- idAux(0,N,R),Res = [R],!.
id(N,L,R,Res):- idAux(L,R,I1),L1 is L-1,R1 is R+1,id(N,L1,R1,I2),append(I2,[I1],Res).

identidad(N,R):-N1 is N-1,id(N1,N1,0,R).
   
matrix_multiply(X,Y,M) :- transpose(Y,T), maplist(row_multiply(T),X,M).

row_multiply(T,X,M) :- maplist(dot(X),T,M).

mul(X,T,M,R):- R is M+X*T.

% opción 2
dot([], [], 0).
dot([H1|T1], [H2|T2], Result) :-
  MH1 is H1 rem 1000000009,
  MH2 is H2 rem 1000000009,
  Prod is MH1 * MH2,
  MProd is Prod rem 1000000009,
  dot(T1, T2, Remaining),
  MRemaining is Remaining rem 1000000009,
  PResult is MProd + MRemaining,
  Result is PResult rem 1000000009.
  
eleMat(Mat, 0,R):- length(Mat,L),identidad(L,R),!.
eleMat(Mat,E,R):- E1 is E rem 2,E1 =:= 0,E2 is E div 2,eleMat(Mat,E2,X),matrix_multiply(X,X,R).
eleMat(Mat,E,R):- E1 is E div 2,eleMat(Mat,E1,X),matrix_multiply(X,X,RX),matrix_multiply(Mat,RX,R).

tn([_, [_,V,_],_],V):-!.

solve(N,R):- eleMat([[0,1,0],[0,0,1],[1,1,1]],N,R1),tn(R1,R2),modTrb(R2,R),!.

tribonacci([0|_]):-!.
tribonacci([H|[]]):- !, solve(H, R), write(R), write('\n').
tribonacci([H|T]):- solve(H, R), write(R), write('\n'), tribonacci(T).



