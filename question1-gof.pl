#include "kb-gof.pl".

% Define the grid size and timestep
#const n = 5.
#const t = 1.

% Define the alive cells
% Center cell and cells to its right and left are alive
cell(3,2,0,1).
cell(3,3,0,1).
cell(3,4,0,1).

% Axioms to define the alive/dead cells at timestep t=1:

alive(X,Y,A) :- cell(X,Y,T,A), T==t, A==1.
#show alive/3.