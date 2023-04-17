% timestep is incremented between 0 and t
timestep(0..t).
timestep(T+1) :- timestep(T), T < t.

% Define valid cells and coordinates on the grid
row(1..n).
col(1..n).
grid_step(-1).
grid_step(1).

% Define a board
diff(X,0) :- grid_step(X).
diff(0,Y) :- grid_step(Y).
diff(X,Y) :- grid_step(X), grid_step(Y).

% Neighboring cells differ in x or y coordinates by a maximum of abs(1)
cell(X,Y) :- row(X), col(Y).
near(X,Y,X+DX,Y+DY) :- row(X), col(Y), diff(DX,DY), cell(X+DX,Y+DY).

% Edge cells always stay dead
border_cell(X,Y) :- cell(X,Y), X == 1. 
border_cell(X,Y) :- cell(X,Y), Y == 1. 
border_cell(X,Y) :- cell(X,Y), X == n. 
border_cell(X,Y) :- cell(X,Y), Y == n. 

{ lives(X,Y,T) } :- cell(X,Y), timestep(T).

active(X,Y,X2,Y2,T) :- near(X,Y,X2,Y2), lives(X2,Y2,T), timestep(T).

overpopulation(X,Y,T) :- cell(X,Y), timestep(T), 4 <= #count{ X2,Y2 : active(X,Y,X2,Y2,T), timestep(T)}.
birth(X,Y,T) :- cell(X,Y), timestep(T), 3 == #count{ X2,Y2 : active(X,Y,X2,Y2,T), timestep(T) }.
loneliness(X,Y,T) :- cell(X,Y), timestep(T), 2 > #count{ X2,Y2 : active(X,Y,X2,Y2,T), timestep(T) }.
preservation(X,Y,T) :- cell(X,Y), timestep(T), 2 == #count{ X2,Y2 : active(X,Y,X2,Y2,T), timestep(T) }.
preservation(X,Y,T) :- cell(X,Y), timestep(T), 3 == #count{ X2,Y2 : active(X,Y,X2,Y2,T), timestep(T) }.

not lives(X,Y,T+1) :- cell(X,Y), lives(X,Y,T), overpopulation(X,Y,T), timestep(T).
not lives(X,Y,T+1) :- border_cell(X,Y), timestep(T+1).
not lives(X,Y,T) :- border_cell(X,Y), timestep(T).
not lives(X,Y,T+1) :- cell(X,Y), lives(X,Y,T), loneliness(X,Y,T), timestep(T).
lives(X,Y,T+1) :- cell(X,Y), lives(X,Y,T), preservation(X,Y,T), timestep(T).
lives(X,Y,T+1) :- cell(X,Y), not lives(X,Y,T), birth(X,Y,T), timestep(T).