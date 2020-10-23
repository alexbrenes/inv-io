-module(bundling_newspapers).
-export([combination/2,combinationAB/3,combinationA/2, combinationEvery/1]).

printAux([H|[]])-> io:format("~p~n",[H]);
printAux([H|T])-> io:format("~p, ",[H]), printAux(T).

print([H|[]]) -> printAux(H);
print([H|T]) -> printAux(H), print(T).

combination(_L,0)->[[]];
combination(L,N)when length(L) =:= N->[L];
combination([H|T], N)-> [[H|Comb] || Comb <- combination(T,N-1)]++combination(T,N).


combinationEvery(L) -> combinationEvery(L, 1).
combinationEvery(L, A) when length(L) == A -> combinationA(L, A);
combinationEvery(L, A) -> combinationA(L, A), combinationEvery(L, A + 1).


combinationAB(L, B, B)-> combinationA(L, B);
combinationAB(L, A, B)-> combinationA(L, A),
			  combinationAB(L, A + 1, B).
			  
combinationA(L, A) -> io:format("~p~n",["Size " ++ integer_to_list(A)]),
		       print(combination(L,A)),
                      io:format("~n",[]).
                      
        
