#include "kb-gof.pl".
% Initial configuration for a 5x5 Game of Life
% Only the center cell and the cells to its right and left are alive
% All other cells are dead

% Define the grid size
size(5).

% Define the alive cells
% Center cell and cells to its right and left are alive
lives(3,2).
lives(3,3).
lives(3,4).

#show lives/2.
% #show initial/2.
% #show.
