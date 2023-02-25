:-op(40, xfy, &).
:-op(50, xfy, --->).

light(l1).
light(l2).
down(s1).
up(s2).
up(s3).
ok(_).

connected_to(l1,w0).
connected_to(w0,w1).
connected_to(w0,w2).
connected_to(w1,w3).
connected_to(w2,w3).
connected_to(l2,w4).
connected_to(w4,w3):- up(s3), ok(s3).
connected_to(p1,w3).
connected_to(w3,w5):- ok(cb1).
connected_to(p2,w6).
connected_to(w6,w5):- ok(cb2).


solve(true):-!.
solve((A & B)) :-!, solve(A), solve(B).
solve(A) :- !, (B ---> A), solve(B).


light(L)& ok(L) & live(L)---> lit(L).
connected_to(W,W1) & live(W1)---> live(W).

%Modelo de dominio
true ---> ok(l1).
true ---> ok(l2).
true ---> ok(s1).
true ---> ok(s2).
true ---> ok(s3).
true ---> ok(cb1).
true ---> ok(cb2).

true ---> live(outside).
true ---> light(l1).
true ---> light(l2).
true ---> down(s1).
true ---> up(s2).
true ---> up(s3).


up(s2) & ok(s2) ---> connected_to(w0,w1).
down(s1) & ok(s1) ---> connected_to(w1,w3).
down(s3) & ok(s3) ---> connected_to(w4,w3).

ok(cb2) ---> connected_to(w6,w5).
ok(cb1) ---> connected_to(w3,w5).

true ---> connected_to(p2,w6).
true ---> connected_to(p1,w3).