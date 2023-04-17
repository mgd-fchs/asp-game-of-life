#include "kb-gof.pl".

% Initial configuration for 5x5 Game of Life
% Only the center cell and the cells to its right and left are alive
% All other cells are dead

% Define the grid size and time step
#const n = 5.
#const t = 1.

% Define the alive cells
% Center cell and cells to its right and left are alive
lives(3,2,0).
lives(3,3,0).
lives(3,4,0).

% Axioms to define the alive/dead cells at timestep t=1:
alive(X,Y) :- cell(X,Y), lives(X,Y,t).
dead(X,Y) :- cell(X,Y), not lives(X,Y,t).

#show alive/2.
#show dead/2.

% python -m clingo question1-gof.pl > log.txt