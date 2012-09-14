/*
 * Order (group theory)
 *
 * The group operation is defined by the table given.
 * The first row (and column) is the neutral one, containing "? `op` e",
 * which also means that it holds the list of all elements in the group.
 *
 * Your task is to write a predicate that computes orders of all the elements.
 * ord(e) = |{ v | v = e^k, k is a positive natural number}|
 *
 * orders(+Table, -Orders)
 */

:- op(500, xfx, '-').

orders([R|Rs], Orders) :-
	orders(R, [R|Rs], [], Orders).

orders([], _, Acc, Acc).
orders([E|Es], Table, Acc, Orders) :-
	[[N|_]|_] = Table,
	oploop(E, E, Table, 1, OrdE),
	orders(Es, Table, [E-OrdE|Acc], Orders).

oploop(E1, E2, Table, Acc, Acc) :-
	operation(E1, E2, Table, E1).
oploop(E1, E2, Table, Acc, Ord) :-
	operation(E1, E2, Table, E3),
	E3 \= E1,
	NewAcc is Acc + 1,
	oploop(E1, E3, Table, NewAcc, Ord).

operation(X, Y, Table, Res) :-
	[R|_] = Table,
	at(1, Ix, [R], X),
	at(1, Iy, [R], Y),
	at(Iy, Ix, Table, Res).

at(1, 1, [[E|_]|_], E).
at(1, C, [[_|T]|_], E) :-
	at(1, NewC, [T], E),
	C is NewC + 1,
	C \= 1.
at(R, C, [_|Rows], E) :-
	at(NewR, C, Rows, E),
	R is NewR + 1,
	R \= 1.
