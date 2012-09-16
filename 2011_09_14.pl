/*
 * Generate all possible bracketing using N opening bracketing.
 *
 * bracketing(+N, -Bracketing)
 */

bracketing(N, Brackets) :- bracketing(N, 0, [], Brackets).

bracketing(0, 0, Acc, Acc).
bracketing(N, D, Acc, Brackets) :-
	D >= 0, N >= 0,
	Nn is N - 1,
	Dn is D + 1,
	bracketing(Nn, Dn, [')'|Acc], Brackets).
bracketing(N, D, Acc, Brackets) :-
	D >= 0, N >= 0,
	Dn is D - 1,
	bracketing(N, Dn, ['('|Acc], Brackets).	

/*
 * Write conversion function between general tree (value + list of children)
 * and canonical tree (list of children is converted into a new node,
 * holding value, sibling and child). It should work in both directions.
 * (http://ksvi.mff.cuni.cz/~topfer/ppt/Progr-7.pdf page 27)
 *
 * g2c(?GeneralTree, ?CanonicalTree)
 */

g2c(GT, CT) :- l2c([GT], CT).

l2c([], nil).
l2c([gt(V, Children)|GTs], ct(V, Child, Sibling)) :-
	l2c(Children, Child),
	l2c(GTs, Sibling).
