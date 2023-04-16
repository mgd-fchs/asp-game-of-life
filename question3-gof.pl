#include "kb-gof.pl".

% Define the grid size and timestep
#const n = 5.
#const t = 5.

% Define the alive cells
% Center cell and cells to its right and left are alive

even(T) :- timestep(T), T \ 2 == 0.
odd(T) :- timestep(T), T \ 2 != 0.

% Axioms to find all cells which are constantly the same throughout the timesteps:
alive_even(X,Y) :- cell(X,Y), lives(X,Y,T), lives(X,Y,T+2), timestep(T).
dead_even(X,Y) :- cell(X,Y), not lives(X,Y,T), not lives(X,Y,T+2), timestep(T).
not dead_even(X,Y) :- cell(X,Y), not lives(X,Y,T), lives(X,Y,T+2), timestep(T).

%alive_odd(X,Y) :- cell(X,Y), lives(X,Y,T), lives(X,Y,T+2), timestep(T), odd(T).
%dead_odd(X,Y) :- cell(X,Y), not lives(X,Y,T), not lives(X,Y,T+2), timestep(T), odd(T).
%not dead_odd(X,Y) :- cell(X,Y), not lives(X,Y,T), lives(X,Y,T+2), timestep(T), odd(T).

#show alive_even/2.
#show dead_even/2.