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

/*
 * Given a list of rectangles and a window, which is yet another rectangle,
 * modify all the rectangles in the list in a way that it shows what parts
 * will be visible in the window.
 *
 * Example: crop(o(10, 30, 30, 10), [o(1, 20, 20, 1)], C).
 *          -> C = [o(10, 20, 20, 10)].
 *
 * crop(+Window, +Rectangles, -VisibleParts)
 */

crop(_, [], []) :- !.
crop(Window, [R|Rectangles], [Intersect|Cropped]) :-
	intersect(Window, R, Intersect),
	Intersect \= void,
	!,
	crop(Window, Rectangles, Cropped).
crop(Window, [_|Rectangles], Cropped) :-
	crop(Window, Rectangles, Cropped).

intersect(o(WTLX, WTLY, WBRX, WBRY), o(RTLX, RTLY, RBRX, RBRY), o(RTLX, RTLY, RBRX, RBRY)) :-
	WTLX =< RTLX, WTLY >= RTLY, WBRX >= RBRX, WBRY =< RBRY,
	!.
intersect(o(WTLX, WTLY, WBRX, WBRY), o(RTLX, RTLY, RBRX, RBRY), void) :-
	(RBRY > WTLY; RTLY < WBRY; RBRX < WTLX; RTLX > WBRX),
	!.
intersect(o(WTLX, WTLY, WBRX, WBRY), o(RTLX, RTLY, RBRX, RBRY), o(MTLX, MTLY, MBRX, MBRY)) :-
	MTLX is max(WTLX, RTLX),
	MTLY is min(WTLY, RTLY),
	MBRX is min(WBRX, RBRX),
	MBRY is max(WBRY, RBRY).

