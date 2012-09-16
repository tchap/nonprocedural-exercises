/*
 * Given a binary search tree and a lower and upper bound,
 * go through that tree and drop all the vertices that do not fit.
 *
 * limitTree(+Tree, +LowerBound, +UpperBound, -NewTree)
 */ 

limitTree(void, _, _, void).
limitTree(t(_, V, R), From, To, NewR) :-
	V < From,
	!,
	limitTree(R, From, To, NewR).
limitTree(t(L, V, _), From, To, NewL) :-
	To < V,
	!,
	limitTree(L, From, To, NewL).
limitTree(t(L, V, R), From, To, t(NewL, V, NewR)) :-
	limitTree(L, From, To, NewL),
	limitTree(R, From, To, NewR).
