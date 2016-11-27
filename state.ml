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
let canDeclare player