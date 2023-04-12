#include "kb-gof.pl".

% Define the grid size and timestep
#const n = 5.
#const t = 5.

% Define the alive cells
% Center cell and cells to its right and left are alive
lives(3,2,0).
lives(3,3,0).
lives(3,4,0).

% Axioms to find all cells which are constantly alive throughout the timesteps:
constant(X,Y) :- cell(X,Y), check_constant(X,Y,0).
check_constant(X,Y,T) :- lives(X,Y,T), timestep(T), T<t.
check_constant(X,Y,T) :- check_constant(X,Y,T+1), timestep(T), T<t.

#show constant/2.