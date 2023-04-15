#include "kb-gof.pl".

% Define the grid size and timestep
#const n = 5.
#const t = 5.

% Define the alive cells
% Center cell and cells to its right and left are alive

lives(3,2,0).
lives(3,3,0).
lives(3,4,0).

% Axioms to find all cells which are constantly the same throughout the timesteps:
alive(X,Y) :- cell(X,Y), lives(X,Y,T), lives(X,Y,T+1), timestep(T).
dead(X,Y) :- cell(X,Y), not lives(X,Y,T), not lives(X,Y,T+1), timestep(T).
not alive(X,Y) :- cell(X,Y), lives(X,Y,T), not lives(X,Y,T+1), timestep(T).
not dead(X,Y) :- cell(X,Y), not lives(X,Y,T), lives(X,Y,T+1), timestep(T).

#show alive/2.
#show dead/2.