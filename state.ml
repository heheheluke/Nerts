open Player

(*Implements the state of the Nerts game, as well the functions
to compute the score of a player and check whether or not a player
has any moves available.*)


(*TYPE DEFINITIONS*)

(*List of players in the current game*)
type players = player list

(*Represents the game's common area of ordered decks, where all players 
contribute cards until the game ends.*)
type commonArea = orderedDeck list

(*Represents the state of the game, including the players currently involved
in the game as well as the state of the common area.*)
type state = {players: players; mutable commonArea: orderedDeck list}

let canDeclare player = 
	if isEmpty player.nerts then true else false

let perform_move player move = 
	match move with
	| Shift (card,deck1,deck2) -> if size deck1 != 0 then 
								  shift_helper player card deck1 deck2
							      else ()
	| Flip -> flip player
	| Declare -> ()



