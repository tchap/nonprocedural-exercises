/*
 * You are given a list or propositional logic variables along with
 * their evaluation. It's of the form [Variable-Value], i.e. [a-0, b-1, ...].
 *
 * Your task is to generate all evaluations that differ in at least 2 (or N)
 * values.
 *
 * diffInMin(+N, +Evaluation, -DiffEvaluations)
 */

:- op(400, xfx, '-').

diffInMin(N, [], []) :-
	N =< 0.
diffInMin(N, [V|Vs], [V|DVs]) :-
	diffInMin(N, Vs, DVs).
diffInMin(N, [Var-Val|Vs], [Var-NVal|DVs]) :-
	Nn is N - 1,
	switch(Val, NVal),
	diffInMin(Nn, Vs, DVs).

switch(0, 1).
switch(1, 0).

/*
 * Given a directed graph without circles and multiedges and a set of vertices,
 * modify the graph in a way that all the vertices in the set are colapsed into
 * a single new vertex. Make sure that there are again no circles and multiedges.
 *
 * collapse(+Graph, +SetOfVertices, -ColapsedGraph)
 */

:- op(400, xfx, '->').

collapse(G, Vs, NewG) :-
	rename(G, Vs, collapsed, NewG),
	\+ path(NewG, collapsed, collapsed).

rename(G, Vs, NewV, [NewV->Out|TempG]) :-
	rename(G, Vs, NewV, [], TempOut, [], TempG),
	filter(TempOut, Vs, [], Out).

rename([], _, _, OAcc, OAcc, GAcc, GAcc).
rename([V->As|Es], Vs, NewV, OAcc, Out, GAcc, G) :-
	member(V, Vs),
	append(As, OAcc, NewOAcc),
	rename(Es, Vs, NewV, NewOAcc, Out, GAcc, G).
rename([V->As|Es], Vs, NewV, OAcc, Out, GAcc, G) :-
	\+ member(V, Vs),
	rename_list(As, Vs, NewV, [], NewAs),
	rename(Es, Vs, NewV, OAcc, Out, [V->NewAs|GAcc], G).

filter([], _, Acc, Acc).
filter([V|Vs], Set, Acc, NewL) :-
	(member(V, Set); member(V, Acc)),
	!,
	filter(Vs, Set, Acc, NewL).
filter([V|Vs], Set, Acc, NewL) :-
	filter(Vs, Set, [V|Acc], NewL).

rename_list([], _, _, Acc, Acc).
rename_list([V|Vs], CVs, NewV, Acc, NewL) :-
	\+ member(V, CVs),
	!,
	rename_list(Vs, CVs, NewV, [V|Acc], NewL).
rename_list([_|Vs], CVs, NewV, Acc, NewL) :-
	\+ member(NewV, Acc),
	!,
	rename_list(Vs, CVs, NewV, [NewV|Acc], NewL).
rename_list([_|Vs], CVs, NewV, Acc, NewL) :-
	rename_list(Vs, CVs, NewV, Acc, NewL).

path(G, V1, V2) :- edge(G, V1, V2).
path(G, V1, V3) :-
	edge(G, V1, V2),
	path(G, V2, V3).

edge([V1->Adjs|_], V1, V2) :-
	member(V2, Adjs),
	!.
edge([_->_|Vs], V1, V2) :-
	edge(Vs, V1, V2).
