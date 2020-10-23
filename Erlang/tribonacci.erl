-module(tribonacci).
-export([tribonacci/1]).

elems(E,Cant)->[E || _X<-lists:seq(1,Cant)].

modTrb(V) -> V rem 1000000009.

transpuesta([])->[];
transpuesta([[]|_T])->[];
transpuesta(M)-> [ [H || [H|_T]<-M] | transpuesta([T||[_H|T]<-M]) ].

identidad(0)->[];
identidad(N)->[ [1|elems(0,N-1)] | [[0|Fila] || Fila<-identidad(N-1)]].

prodPto(V,W)->lists:foldl(fun({V1,W1},A)-> modTrb((modTrb(V1)*modTrb(W1))+modTrb(A)) end, 0, lists:zip(V,W)).

mulMat(M1,M2)-> TM2 = transpuesta(M2), [ [prodPto(Fila,Colu) || Colu <- TM2] || Fila<-M1].

eleMat(Mat, 0)-> identidad(length(Mat));
eleMat(Mat,E) when E rem 2 =:= 0-> X = eleMat(Mat, E div 2), mulMat(X,X);
eleMat(Mat,E)->X = eleMat(Mat, E div 2), mulMat(Mat,mulMat(X,X)).

tn([_, [_,V,_],_]) -> V.

tribonacci(N) -> tn(eleMat([[0,1,0]
			    ,[0,0,1]
			    ,[1,1,1]],N)).
