% timestep is incremented between 0 and t
timestep(0..t).
timestep(T+1) :- timestep(T), T < t.

% Define valid cells and coordinates on the grid
row(1..n).
col(1..n).
life(0;1).

% Define neighbor relationships
grid_step(-1).
grid_step(1).

diff(X,0) :- grid_step(X).
diff(0,Y) :- grid_step(Y).
diff(X,Y) :- grid_step(X), grid_step(Y).

% Neighboring cells differ in x or y coordinates by a maximum of abs(1)
cell(X,Y,T,L) :- row(X), row(Y), timestep(T), life(L).
near(X,Y,X+DX,Y+DY) :- row(X), row(Y), diff(DX,DY), cell(X+DX,Y+DY,_,_).

% Edge cells always stay dead
border_cell(X,Y,T,L) :- cell(X,Y,T,L), X == 1. 
border_cell(X,Y,T,L) :- cell(X,Y,T,L), Y == 1. 
border_cell(X,Y,T,L) :- cell(X,Y,T,L), X == n. 
border_cell(X,Y,T,L) :- cell(X,Y,T,L), Y == n. 

active(X,Y,XX,YY,T) :- near(X,Y,XX,YY), cell(X,Y,T,1), timestep(T).

overpopulation(X,Y,T) :- cell(X,Y,T,L), timestep(T), 4 <= #count{ XX,YY : active(X,Y,XX,YY,T), timestep(T)}.
birth(X,Y,T) :-cell(X,Y,T,L), timestep(T), 3 == #count{ XX,YY : active(X,Y,XX,YY,T), timestep(T) }.
loneliness(X,Y,T) :- cell(X,Y,T,L), timestep(T), 2 > #count{ XX,YY : active(X,Y,XX,YY,T), timestep(T) }.
preservation(X,Y,T) :-cell(X,Y,T,L), timestep(T), 2 == #count{ XX,YY : active(X,Y,XX,YY,T), timestep(T) }.
preservation(X,Y,T) :-cell(X,Y,T,L), timestep(T), 3 == #count{ XX,YY : active(X,Y,XX,YY,T), timestep(T) }.

cell(X,Y,T+1,0) :- cell(X,Y,T,L), cell(X,Y,T,1), overpopulation(X,Y,T), timestep(T).
cell(X,Y,T+1,0) :- border_cell(X,Y,T,L), timestep(T+1).
cell(X,Y,T,0) :- border_cell(X,Y,T,L), timestep(T).
cell(X,Y,T+1,0) :- cell(X,Y,T,L), cell(X,Y,T,1), loneliness(X,Y,T), timestep(T).
cell(X,Y,T+1,1) :- cell(X,Y,T,L), cell(X,Y,T,1), preservation(X,Y,T), timestep(T).
cell(X,Y,T+1,1) :- cell(X,Y,T,L), cell(X,Y,T,1), birth(X,Y,T), timestep(T).

% cell(X,Y,T,A)