combination(_,0,[]).
combination([H|T],K,[H|C]):-K>0,K1 is K-1,combination(T,K1,C).
combination([_H|T],K,C):-K>0,combination(T,K,[C]).


combinationAux(L, A):- [combination(L,A,X)].
