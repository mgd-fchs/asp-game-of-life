#include "kb-gof.pl".
% Initial configuration for a 5x5 Game of Life
% Only the center cell and the cells to its right and left are alive
% All other cells are dead

% Define the grid size

size(5).

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

not lives(3,1,0).
not lives(3,5,0).

#show lives/3.