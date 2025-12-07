find_exit(_Maze, _Actions) :-
    writeln('find_exit/2 stub called'),
    fail.


% For now, we assume the maze is rectangular if it loads correctly.
maze_dimensions(Maze, NumRows, NumCols) :-
    length(Maze, NumRows),
    Maze = [FirstRow | _],
    length(FirstRow, NumCols).

% A tiny sample maze for testing (not part of final API; just for you).
sample_maze([
    [w, w, w],
    [w, s, e],
    [w, w, w]
]).

% Succeeds with the Cell at that position, or fails if the indices are out of bounds.
cell_at(Maze, RowIdx, ColIdx, Cell) :-
    nth0(RowIdx, Maze, Row),
    nth0(ColIdx, Row, Cell).

find_start(Maze, RowIdx, ColIdx) :-
    nth0(RowIdx, Maze, Row),
    nth0(ColIdx, Row, s).


% True if the given Cell (e.g., s or e) appears anywhere in the maze.
has_cell(Maze, Cell) :-
    member(Row, Maze),
    member(Cell, Row).



% valid_maze_basic(+Maze)
% Basic sanity checks:
%   - Maze has at least one row and one column (via maze_dimensions/3).
%   - Maze contains at least one 's' (start).
%   - Maze contains at least one 'e' (exit).
valid_maze_basic(Maze) :-
    maze_dimensions(Maze, _NumRows, _NumCols),
    has_cell(Maze, s),
    has_cell(Maze, e).


% exactly_one_start(+Maze)
% True if the maze has one 's' cell and no other distinct 's' cells.
exactly_one_start(Maze) :-
    % Find one start position
    find_start(Maze, Row, Col),
    % Assert there is no *different* second start
    \+ (
        find_start(Maze, Row2, Col2),
        (Row2 \= Row ; Col2 \= Col)
    ).
