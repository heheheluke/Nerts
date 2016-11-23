open Player

(*Implements the state of the Nerts game, as well the functions
to compute the score of a player and check whether or not a player
has any moves available.*)


(*TYPE DEFINITIONS*)

(*List of players in the current game*)
type players = player list

(*Represents the state of the game, including the players currently involved
in the game as well as the state of the common area.*)
type state = players * commonArea

(*Represents the game's common area of ordered decks, where all players 
contribute cards until the game ends.*)
type commonArea = orderedDeck list

(*FUNCTION DEFINITIONS*)

(*Given a player, returns true if the player has any moves available in
the current state of the game, and false otherwise.*)
val hasMovesCurrently : player -> commonArea -> bool

(*Given a player, returns true if the player has any moves if the player
flipped through their stock pile, and false otherwise.*)
val hasAnyMoves : player -> commonArea -> bool

(*Given a player and a common area, returns the score of the player, which
is the number of cards they have contributed to the common area.*)
val computePoints : commonArea -> player -> int

(*Given a player, returns true if the player has emptied their nerts pile
and can declare "Nerts" to end the game, and false otherwise.*)
val canDeclare : player -> bool