-module(ts).
-export([readF/1]).

repeat(0, _V) -> [];
repeat(K, V) -> [V] ++ repeat(K-1, V).

matrix(N, M, V) -> repeat(N, repeat(M,V)).

elementAt([H|_],1) -> H;
elementAt([_|T],K) -> elementAt(T, K - 1).

solve(_, _Memo, H, _N, _M) when H < 0 -> -1073741824;
solve(_, _Memo, _H, 0, _M) -> 0;
solve(_, [[V|_]|_], _H, _N, _M) when V > 0-> V;
solve([F|T], Memo, H, N, M) -> V = [elementAt(F, X) + solve(T, Memo,H - X, N - 1, M) || X<-lists:seq(1, M), elementAt(F, X) >= 5],
			      lists:foldl(fun(A, MXV) -> max(A, MXV) end, -1073741824, V).

printSol(V) when V < 5 -> io:format("Peter, you shouldn't have played billiard that much.~n",[]);
printSol(V) -> io:format("Maximal possible average mark - ~.2f.~n", [V]).

ts(A, N, M)-> printSol(solve(A, matrix(N, M, -1073741824), M, N, M) / N).

readF(Filename) -> {ok, Device} = file:open(Filename,[read]), {_, [V]} = io:fread(Device,[],"~d"), tcases(V, Device).

mkMatrix(N, M, Device) -> [mkRow(M, Device) || _X<-lists:seq(1, N)].

mkRow(0, _Device) -> [];
mkRow(M, Device) -> {_,V} = io:fread(Device, [],"~d"), V ++ mkRow(M - 1, Device).

rdim(Device) -> {_,[N, M]} = io:fread(Device,[],"~d ~d"), ts(mkMatrix(N, M, Device), N, M).

tcases(1, Device) -> rdim(Device);
tcases(T, Device) -> rdim(Device), tcases(T - 1, Device).
