% Timestep is incremented between 0 and 5
timestep(0..5).
timestep(0).
timestep(T+1) :- timestep(T), T < 5.

% Define valid cells and coordinates on the grid
value(0).
value(V+1) :- value(V), size(N), V <= N.
step(-1).
step(1).

diff(X,0) :- step(X).
diff(0,Y) :- step(Y).
diff(X,Y) :- step(X), step(Y).

% Neighboring cells differ in x or y coordinates by a maximum of abs(1)
cell(X,Y) :- value(X), value(Y), size(N), 0 < X, 0 < Y, X <= N, Y <= N.
near(X,Y,X+DX,Y+DY) :- value(X), value(Y), diff(DX,DY), cell(X+DX,Y+DY).

border_cell(X, Y) :- cell(X, Y), X == 1. 
border_cell(X, Y) :- cell(X, Y), Y == 1. 
border_cell(X, Y) :- cell(X, Y), X == size(N). 
border_cell(X, Y) :- cell(X, Y), Y == size(N). 

{ lives(X,Y,T) } :- cell(X,Y), timestep(T).
lives(X,Y,T) | notlives(X,Y,T) :- cell(X,Y), timestep(T).
lives(X,Y,T) | not lives(X,Y,T) :- cell(X,Y), timestep(T).

active(X,Y,X,Y,T) :- lives(X,Y,T), timestep(T).
active(X,Y,XX,YY,T) :- near(X,Y,XX,YY), lives(XX,YY,T), timestep(T).

overpopulation(X,Y,T) :- cell(X,Y), timestep(T), 4 <= #count{ XX,YY : active(X,Y,XX,YY,T), timestep(T)}.
birth(X,Y,T) :- cell(X, Y), timestep(T), 3 == #count{ XX,YY : active(X,Y,XX,YY,T), timestep(T) }.
loneliness(X,Y,T) :- cell(X,Y), timestep(T), 2 > #count{ XX,YY : active(X,Y,XX,YY,T), timestep(T) }.
preservation(X,Y,T) :- cell(X, Y), timestep(T), 2 == #count{ XX,YY : active(X,Y,XX,YY,T), timestep(T) }.
preservation(X,Y,T) :- cell(X, Y), timestep(T), 3 == #count{ XX,YY : active(X,Y,XX,YY,T), timestep(T) }.

not lives(X,Y,T+1) :- cell(X,Y), lives(X,Y,T), overpopulation(X,Y,T), timestep(T).
not lives(X,Y,T+1) :- border_cell(X,Y), timestep(T+1).
not lives(X,Y,T) :- border_cell(X,Y), timestep(T).
not lives(X,Y,T+1) :- cell(X,Y), lives(X,Y,T), loneliness(X,Y,T), timestep(T).
lives(X,Y,T+1) :- cell(X,Y), lives(X,Y,T), preservation(X,Y,T), timestep(T).
lives(X,Y,T+1) :- cell(X,Y), not lives(X,Y,T), birth(X,Y,T), timestep(T).


%neighbors(X,Y,XX,YY) :- near(X,Y,XX,YY), cell(X,Y), lives(X,Y,T), timestep(T).
%neighbors(X,Y,XX,YY) :- near(X,Y,XX,YY), cell(X,Y), -lives(XX,YY,T), timestep(T).