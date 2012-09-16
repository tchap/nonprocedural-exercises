/*
 * Given a simple undirected graph in the form of [a-b, b-c, ...],
 * where every edge is given only once (like asymmetric relation),
 * compute degrees of all the vertices in the graph.
 *
 * degrees(+Graph, -Degrees)
 */ 

:- op(400, xfx, '-').

degrees(G, Ds) :-
	vertices(G, [], Vs),
	degrees(G, Vs, Ds).

vertices([], Acc, Acc).
vertices([X-Y|Es], Acc, Vs) :-
	\+ member(X, Acc),
	\+ member(Y, Acc),
	!,
	vertices(Es, [X,Y|Acc], Vs).
vertices([X-_|Es], Acc, Vs) :-
	\+ member(X, Acc),
	!,
	vertices(Es, [X|Acc], Vs).
vertices([_-Y|Es], Acc, Vs) :-
	\+ member(Y, Acc),
	!,
	vertices(Es, [Y|Acc], Vs).
vertices([_|Es], Acc, Vs) :-
	vertices(Es, Acc, Vs).

degrees(_, [], []) :- !.
degrees(G, [V|Vs], [V-D|Ds]) :-
	degree(G, V, D),
	degrees(G, Vs, Ds).

degree([], _, 0) :- !.
degree([V-_|Es], V, D) :-
	degree(Es, V, TempD),
	D is TempD + 1,
	!.
degree([_-V|Es], V, D) :-
	degree(Es, V, TempD),
	D is TempD + 1,
	!.
degree([_|Es], V, D) :-
	degree(Es, V, D).
