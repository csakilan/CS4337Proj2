find_exit(_Maze, _Actions) :-
    writeln('find_exit/2 stub called'),
    fail.


% maze_dimensions(+Maze, -NumRows, -NumCols)
% Succeeds if Maze has NumRows rows and each row has NumCols columns.
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

% cell_at(+Maze, +RowIdx, +ColIdx, -Cell)
% Using 0-based indices:
%   RowIdx = 0 is the first row
%   ColIdx = 0 is the first column
% Succeeds with the Cell at that position, or fails if the indices are out of bounds.
cell_at(Maze, RowIdx, ColIdx, Cell) :-
    nth0(RowIdx, Maze, Row),
    nth0(ColIdx, Row, Cell).

