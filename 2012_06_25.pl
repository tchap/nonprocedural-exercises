/*
 * Cluster of reachability
 * 
 * Given a non-oriented graph G, which is a list of edges with their weights,
 * (in our case the format is v1-v2/w), find all the vertices that are reachable
 * from the vertex given. The lenght of the path must not exceed the threshold.
 *
 * Every edge is in the graph only once, e.g. v1-v2/w, but not v2-v1/w.
 * Edge cost is always positive.
 *
 * cluster(+Graph, +Start, +Threshold, -Cluster)
 */

:- op(500, xfx, -).
:- op(510, xfx, /).

cluster(G, S, T, C) :-
	cluster(G, [[S, 0]], T, [], Cl),
	unique(Cl, C).

cluster(_, [], _, Visited, Visited) :- !.
cluster(G, [[V, L]|Open], T, Visited, Cluster) :-
	extend(G, V, L, T, Extends),
	append(Open, Extends, NewOpen),
	cluster(G, NewOpen, T, [V|Visited], Cluster).

extend([], _, _, _, []) :- !.
extend([V1-V2/W|Edges], V1, L, T, [[V2, EL]|Extends]) :-
	EL is L + W, EL =< T,
	extend(Edges, V1, L, T, Extends),
	!.
extend([V2-V1/W|Edges], V1, L, T, [[V2, EL]|Extends]) :-
	EL is L + W, EL =< T,
	extend(Edges, V1, L, T, Extends),
	!.
extend([_|Edges], V, L, T, Extends) :-
	extend(Edges, V, L, T, Extends).

unique(L, UL) :- unique(L, [], UL).

unique([], Acc, Acc).
unique([M|L], Acc, UL) :- 
	member(M, Acc),
	!,
	unique(L, Acc, UL).
unique([M|L], Acc, UL) :-
	\+ member(M, Acc),
	!,
	unique(L, [M|Acc], UL).

/*
 * Binary Search Tree Bubble
 *
 * You are given a binary search tree, which is a recurive DS in the form of
 * t(Left, Value, Right). You are also given a value. Transform the tree
 * in a way that you get the given value into the root of the tree.
 *
 * transf(+BST, +V, -BST)
 */

transf(t(L, V, R), V, t(L, V, R)).
transf(t(L, V, R), X, NewTree) :-
	X < V,
	transf(L, X, t(CL, X, CR)),
	NewTree = t(CL, X, t(CR, V, R)).
transf(t(L, V, R), X, NewTree) :-
	X > V,
	transf(R, X, t(CL, X, CR)),
	NewTree = t(t(L, V, CL), X, CR).
