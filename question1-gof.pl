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

not lives(1,1,0).
not lives(1,2,0).
not lives(1,3,0).
not lives(1,4,0).
not lives(1,5,0).

not lives(2,1,0).
not lives(2,2,0).
not lives(2,3,0).
not lives(2,4,0).
not lives(2,5,0).

not lives(3,1,0).
not lives(3,5,0).

not lives(4,1,0).
not lives(4,2,0).
not lives(4,3,0).
not lives(4,4,0).
not lives(4,5,0).

not lives(5,1,0).
not lives(5,2,0).
not lives(5,3,0).
not lives(5,4,0).
not lives(5,5,0).

% Axioms to define the alive/dead cells at timestep t=1:
alive(X,Y) :- cell(X,Y), lives(X,Y,t).
dead(X,Y) :- cell(X,Y), not lives(X,Y,t).

%:- cell(X,Y), lives(X,Y,T), not lives(X,Y,T+1), timestep(T).
%:- cell(X,Y), not lives(X,Y,T), lives(X,Y,T+1), timestep(T).

#show alive/2.
#show dead/2.