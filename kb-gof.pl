value(0).
value(V+1) :- value(V), size(N), V <= N.
step(-1).
step(1).

diff(X,0) :- step(X).
diff(0,Y) :- step(Y).
diff(X,Y) :- step(X), step(Y).

% neighboring cells differ in x or y coordinates by a maximum of abs(1)
cell(X,Y) :- value(X), value(Y), size(N), 0 < X, 0 < Y, X <= N, Y <= N.
near(X,Y,X+DX,Y+DY) :- value(X), value(Y), diff(DX,DY), cell(X+DX,Y+DY).

{ lives(X,Y) } :- cell(X,Y).
lives(X,Y) | notLives(X,Y) :- cell(X,Y).
lives(X,Y) | -lives(X,Y) :- cell(X,Y).

active(X,Y,X,Y) :- lives(X,Y).
active(X,Y,XX,YY) :- near(X,Y,XX,YY), lives(XX,YY).

% TODO: Add rules for death/birth of cells
overpopulation(X,Y) :- cell(X,Y), 4 <= #count{ XX,YY : active(X,Y,XX,YY), near(X,Y,XX,YY) }.
birth(X,Y) :- cell(X, Y), 3 == #count{ XX,YY : active(X,Y,XX,YY), near(X,Y,XX,YY) }.
loneliness(X, Y) :- cell(X,Y), 2 > #count{ XX,YY : active(X,Y,XX,YY), near(X,Y,XX,YY) }.
preservation(X, Y) :- cell(X, Y), 2 == #count{ XX,YY : active(X,Y,XX,YY), near(X,Y,XX,YY) }.
preservation(X, Y) :- cell(X, Y), 3 == #count{ XX,YY : active(X,Y,XX,YY), near(X,Y,XX,YY) }.

dead(X,Y) :- cell(X, Y), lives(X,Y), overpopulation(X,Y).
dead(X,Y) :- cell(X, Y), lives(X,Y), loneliness(X,Y).
lives(X,Y) :- cell(X, Y), lives(X,Y), preservation(X,Y).
lives(X,Y) :- cell(X,Y), not lives(X,Y), birth(X,Y).

% TODO: Fix initial config
neighbors(X,Y,XX,YY) :- near(X,Y,XX,YY), lives(X,Y).
neighbors(X,Y,XX,YY) :- near(X,Y,XX,YY), cell(X,Y), not lives(XX,YY).
initial(1,1) :- cell(1,1).
initial(X+1,Y) :- initial(X,Y), cell(X+1,Y), not lives(X,Y).
initial(1,Y+1) :- initial(X,Y), size(X), not size(Y), not lives(X,Y).
reached(X,Y) :- initial(X,Y).
reached(XX,YY) :- reached(X,Y), neighbors(X,Y,XX,YY).
:- cell(X,Y), not reached(X,Y).
