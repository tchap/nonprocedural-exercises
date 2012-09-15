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
