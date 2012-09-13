/*
 * You are given 2 lists, each containing up to 1 '*',
 * which can be substituted for any sequence of numbers.
 * Your task is to decide whether those 2 lists are equivalent,
 * e.g. '*' in those list can be substituted in a way that
 * you get the same list.
 *
 * Example: [1, 2, *, 7, 7] is equivalent to [1, *, 7] 
 *
 * equiv(+L1, +L2)
 */

equiv(L1, L2) :-
	strip_common(L1, L2, C1, C2),
	equiv_core(C1, C2),
	!.

strip_common(L1, L2, C1, C2) :- 
	strip_common_prefix(L1, L2, PL1, PL2),
	reverse(PL1, RPL1),
	reverse(PL2, RPL2),
	strip_common_prefix(RPL1, RPL2, C1, C2).

strip_common_prefix(L1, L2, L1, L2) :-
	L1 = [] ; L2 = [].
strip_common_prefix([X|Xs], [Y|Ys], [X|Xs], [Y|Ys]) :-
	X \= Y; X = '*'; Y = '*'.
strip_common_prefix([X|Xs], [X|Ys], C1, C2) :-
	strip_common_prefix(Xs, Ys, C1, C2).

equiv_core(['*'], _).
equiv_core(_, ['*']).
equiv_core(['*'|_], L2) :- last(L2, '*').
equiv_core(L1, ['*'|_]) :- last(L1, '*').
