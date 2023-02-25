:-op(40, xfy, &).
:-op(50, xfy, --->).

light(l1).
light(l2).
down(s1).
up(s2).
up(s3).
ok(_).

connected_to(l1,w0).
connected_to(w0,w1):- up(s2).
connected_to(w0,w2):- down(s2).
connected_to(w1,w3):- up(s1).
connected_to(w2,w3):- down(s1).
connected_to(l2,w4).
connected_to(w4,w3):- up(s3).
connected_to(p1,w3).
connected_to(w3,w5).
connected_to(p2,w6).
connected_to(w6,w5).

lit(L):-live(L),ok(L),light(L).
live(outside).
live(w):- connected_to(w,w1),live(w1).

solve(true):-!.
solve((A & B)) :-!, solve(A), solve(B).
solve(A) :- !, (B ---> A), solve(B).

dsolve(true,D,D):-!.
dsolve((A,B), D1,D2) :-!, dsolve(A,D1,D3), dsolve(B,D3,D2).
dsolve(A,D,[A|D]) :- delay(A).
dsolve(A,D1,D2) :- clause(A, B), dsolve(B,D1,D2).
delay(ok(_)).