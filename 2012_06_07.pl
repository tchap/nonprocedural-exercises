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

/*
 * Given a list of vectors (which are in turn list of integers),
 * find all vectors that are not dominated by any other.
 * A vector v1 is dominated by v2 iff v1_i =< v2_i for all 0 < i =< len(v1).
 */

paretoMax(Vs, OutVs) :-
	paretoMax(Vs, Vs, OutVs).

paretoMax(_, [], []) :- !.
paretoMax(All, [V|Vs], [V|OutVs]) :-
	select(V, All, Rest),
	check(V, Rest),
	!,
	paretoMax(All, Vs, OutVs).
paretoMax(All, [_|Vs], OutVs) :-
	paretoMax(All, Vs, OutVs).

check(_, []).
check(V, [O|Others]) :-
	\+ dominatedBy(V, O),
	check(V, Others).

dominatedBy([], []).
dominatedBy([V1|V1s], [V2|V2s]) :-
	V1 =< V2,
	dominatedBy(V1s, V2s).
