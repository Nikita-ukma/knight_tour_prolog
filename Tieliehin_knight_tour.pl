knight_tour(N, M, Path) :-
    Size is N * M,
    length(Path, Size),
    start_position(N, M, X, Y),
    tour(N, M, [(X,Y)], Path).

start_position(_, _, 1, 1).

tour(_, _, Path, Path) :- !.

tour(N, M, [(X,Y)|Visited], Path) :-
    move(X, Y, X1, Y1, N, M),
    \+ member((X1, Y1), Visited),
    tour(N, M, [(X1,Y1),(X,Y)|Visited], Path).

move(X, Y, X1, Y1, N, M) :-
    knight_moves(DX, DY),
    X1 is X + DX, Y1 is Y + DY,
    X1 > 0, X1 =< N, Y1 > 0, Y1 =< M.

knight_moves(2, 1).
knight_moves(2, -1).
knight_moves(-2, 1).
knight_moves(-2, -1).
knight_moves(1, 2).
knight_moves(1, -2).
knight_moves(-1, 2).
knight_moves(-1, -2).

print_board(N, M, Path) :-
    findall((X, Y, Step), nth1(Step, Path, (X, Y)), Board),
    forall(between(1, N, I), (
        forall(between(1, M, J), (
            (member((I, J, Step), Board) -> format('~|~`0t~d~3+', [Step]); write(' . ')),
            write(' ')
        )),
        nl
    )).
 
