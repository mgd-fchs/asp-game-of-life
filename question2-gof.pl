#include "kb-gof.pl".

% Define the grid size and timestep
#const n = 5.
#const t = 14.

% Axioms to find all configurations which are constantly the same throughout several timesteps:
alive(X,Y) :- cell(X,Y), lives(X,Y,T), lives(X,Y,T+1), timestep(T).
dead(X,Y) :- cell(X,Y), not lives(X,Y,T), not lives(X,Y,T+1), timestep(T).
not alive(X,Y) :- cell(X,Y), lives(X,Y,T), not lives(X,Y,T+1), timestep(T).
not dead(X,Y) :- cell(X,Y), not lives(X,Y,T), lives(X,Y,T+1), timestep(T).

% TODO: Encode in configuration (one board for all cells per timestep) and compare those

#show alive/2.
#show dead/2.