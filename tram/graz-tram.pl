% Define stops
stop(Jakominiplatz).
stop(Karlauerguertel).
stop(Jakominiguertel).
stop(Jauerburggasse).
stop(Libenau).

% Define connections between stops
connected(Jakominiplatz, Jakominiguertel).
connected(Jakominiguertel, Jauerburggasse).
connected(Jauerburggasse, Libenau).
connected(Jakominiguertel, Karlauerguertel).