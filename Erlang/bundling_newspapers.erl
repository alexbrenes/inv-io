-module(bundling_newspapers).
-export([bn/1]).

printAux([H|[]])-> io:format("~p~n",[H]);
printAux([H|T])-> io:format("~p, ",[H]), printAux(T).

print([H|[]]) -> printAux(H);
print([H|T]) -> printAux(H), print(T).

combination(_L,0)->[[]];
combination(L,N)when length(L) =:= N->[L];
combination([H|T], N)-> [[H|Comb] || Comb <- combination(T,N-1)]++combination(T,N).


combinationEvery(L) -> combinationAB(L,1, length(L)).

combinationAB(L, B, B)-> combinationA(L, B);
combinationAB(L, A, B)-> combinationA(L, A),
			  combinationAB(L, A + 1, B).
			  
combinationA(L, A) -> io:format("~p~n",["Size " ++ integer_to_list(A)]),
		       print(combination(L,A)),
                      io:format("~n",[]).


bn([[['*'|[]]|[Newspapers]]|T]) -> combinationEvery(Newspapers), bn(T);
bn([[[A|[]]|[Newspapers]]|T]) -> combinationA(Newspapers, A), bn(T);
bn([[[A, B]|[Newspapers]]|T]) -> combinationAB(Newspapers, A, B), bn(T);
bn([])->ok.

