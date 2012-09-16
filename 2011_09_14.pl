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
