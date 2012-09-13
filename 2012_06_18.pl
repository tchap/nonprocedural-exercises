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

/*
 * You are given a list showing you which elements are comparable while a->b
 * means a < b. Find all pairs of elements that are not comparable,
 * e.g. there is no path from one element to the other.
 *
 * uncomp(+G, -UC)
 */ 

:- op(500, xfx, '-').
:- op(500, xfx, '->').

incomparable(Es, UCs) :-
	vertices(Es, [], Vs),
	findall_incomparable(Es, Vs, UCs).

vertices([], Acc, UAcc) :- unique(Acc, [], UAcc).
vertices([X->Y|Es], Acc, Vs) :-
	vertices(Es, [X,Y|Acc], Vs).

unique([], Acc, Acc).
unique([X|Xs], Acc, Uniq) :-
	member(X, Acc),
	!,
	unique(Xs, Acc, Uniq).
unique([X|Xs], Acc, Uniq) :-
	unique(Xs, [X|Acc], Uniq).

findall_incomparable(Es, Vs, Ps) :- findall_icmp(Es, Vs, [], Ps).

findall_icmp(Es, Vs, Acc, Ps) :-
	member(X, Vs),
	member(Y, Vs),
	X \= Y,
	\+ member(X-Y, Acc),
	\+ member(Y-X, Acc),
	\+ comparable(Es, X, Y),
	\+ comparable(Es, Y, X),
	findall_icmp(Es, Vs, [X-Y|Acc], Ps),
	!.
findall_icmp(_, _, Acc, Acc).

comparable(Es, X, Z) :- member(X->Z, Es).
comparable(Es, X, Z) :- 
	member(X->Y, Es),
	comparable(Es, Y, Z).
