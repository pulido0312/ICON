mooreTabla(q0,a,q2).
mooreTabla(q0,b,q1).
mooreTabla(q1,a,q0).
mooreTabla(q1,b,q3).
mooreTabla(q2,a,q2).
mooreTabla(q2,b,q3).
mooreTabla(q3,a,q0).
mooreTabla(q3,b,q3).


transita(X,[],X):- !.
transita(X,[A|B]:-mooreTabla(X,A,P), transita(P,B,Y),!.

acepta(X):-transita(q0,X,Y),y=q1.