palindromo(X):-name(X,L),longitud(L,T),W is T//2, pila(L,W,M),descarte(L,K), comparar(K,M).

longitud([],0).
longitud([L|L1],T):- longitud(L1,T1), T is T1+1.

pila(_,0,Y).
pila([X|Xj],W,[Y|Ys]):- W1 is W-1, pila(Xj,W1,[X|[Y|Ys]]).

descarte([Z|Zs],Zs).

comparar([],[]):-true.
comparar([L|Ls],[M|Ms]):- L =:= M, comparar(Ls,Ms).