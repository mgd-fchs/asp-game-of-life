#include "kb-gof.pl".

% Define the grid size and timestep
#const n = 5.
#const t = 11.

% Note: Query only with odd numbers of t. See report.

even(T) :- timestep(T), T \ 2 == 0, T>=0.

alive(X,Y) :- cell(X,Y), lives(X,Y,T), even(T).
dead(X,Y) :- cell(X,Y), not lives(X,Y,T), even(T).

% Exclude cells that do not repeat with period 2
:- cell(X,Y), lives(X,Y,T), not lives(X,Y,T+2), even(T).
:- cell(X,Y), not lives(X,Y,T), lives(X,Y,T+2), even(T).

#show alive/2.
#show dead/2.