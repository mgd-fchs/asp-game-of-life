% Read problem input
#include "problem-tram.pl".
#include "graz-tram.pl".

% Define variables
% path(From, To, Length, [Intermediate Stops])
path(From, To, Length, [From, To]) :- connected(From, To), distance(From, To, Length).
path(From, To, Length, [From|Rest]) :- connected(From, Next), distance(From, Next, NextLength), path(Next, To, RestLength, Rest), Length is NextLength + RestLength.

% Objective: minimize the length of the path
#minimize { Length : path(From, To, Length, _) }.
