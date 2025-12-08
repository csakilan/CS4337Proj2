% find_exit(+Maze, +Actions)
% Mode 1: Actions is given (non-variable).
% Verify that following Actions from the start leads to an exit.
find_exit(Maze, Actions) :-
    nonvar(Actions),
    valid_maze(Maze),
    find_start(Maze, StartRow, StartCol),
    StartPos = pos(StartRow, StartCol),
    follow_actions(Maze, StartPos, Actions, EndPos),
    is_exit(Maze, EndPos).

% find_exit(+Maze, -Actions)
% Mode 2: Actions is unbound (variable).
% Generate an action list that leads from the start to some exit.
find_exit(Maze, Actions) :-
    var(Actions),
    valid_maze(Maze),
    find_start(Maze, StartRow, StartCol),
    StartPos = pos(StartRow, StartCol),
    search_path(Maze, StartPos, [StartPos], Actions, EndPos),
    is_exit(Maze, EndPos).

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
valid_maze_basic(Maze) :-
    maze_dimensions(Maze, _NumRows, _NumCols),
    has_cell(Maze, s),
    has_cell(Maze, e).


% True if the maze has one 's' cell and no other distinct 's' cells.
exactly_one_start(Maze) :-
    % Find one start position
    find_start(Maze, Row, Col),
    % Assert there is no *different* second start
    \+ (
        find_start(Maze, Row2, Col2),
        (Row2 \= Row ; Col2 \= Col)
    ).

% True if all rows have the same length (rectangular maze).
all_rows_same_length([]).
all_rows_same_length([FirstRow | RestRows]) :-
    length(FirstRow, Len),
    forall(member(Row, RestRows), length(Row, Len)).

% True if Cell is one of the allowed maze symbols.
valid_cell(w).
valid_cell(f).
valid_cell(s).
valid_cell(e).

all_cells_valid(Maze) :-
    forall(
        ( member(Row, Maze),
          member(Cell, Row)
        ),
        valid_cell(Cell)
    ).

valid_maze(Maze) :-
    valid_maze_basic(Maze),
    exactly_one_start(Maze),
    all_rows_same_length(Maze),
    all_cells_valid(Maze).


% Pos and NewPos are pos(Row, Col) with 0-based indices.
% Action is one of left, right, up, down.
% This predicate ONLY updates the coordinates; it does NOT check walls or bounds.
step(pos(Row, Col), left,  pos(Row, ColLeft))  :-
    ColLeft is Col - 1.
step(pos(Row, Col), right, pos(Row, ColRight)) :-
    ColRight is Col + 1.
step(pos(Row, Col), up,    pos(RowUp, Col))    :-
    RowUp  is Row - 1.
step(pos(Row, Col), down,  pos(RowDown, Col))  :-
    RowDown is Row + 1.


% Maze is assumed to be valid (use valid_maze/1 before calling this).
legal_step(Maze, Pos, Action, NewPos) :-
    step(Pos, Action, NewPos),
    % unpack NewPos to row and column
    NewPos = pos(Row, Col),
    cell_at(Maze, Row, Col, Cell),
    Cell \= w.

% Fails if any step is illegal.
follow_actions(_Maze, Pos, [], Pos).
follow_actions(Maze, Pos, [Action | RestActions], EndPos) :-
    legal_step(Maze, Pos, Action, NextPos),
    follow_actions(Maze, NextPos, RestActions, EndPos).


% is_exit(+Maze, +Pos)
% True if Pos is on an exit cell 'e' in the maze.
is_exit(Maze, pos(Row, Col)) :-
    cell_at(Maze, Row, Col, e).



search_path(Maze, CurrentPos, _Visited, [], CurrentPos) :-
    is_exit(Maze, CurrentPos).

% Recursive case: try a legal action, move to NextPos, and continue search.
search_path(Maze, CurrentPos, Visited, [Action | RestActions], EndPos) :-
    member(Action, [left, right, up, down]),
    legal_step(Maze, CurrentPos, Action, NextPos),
    \+ member(NextPos, Visited),
    search_path(Maze, NextPos, [NextPos | Visited], RestActions, EndPos).
