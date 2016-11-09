open State

(*Implements a single player in the game Nerts, as well as the
actions a player can perform*)

(*TYPE DEFINITIONS*)

(*Variant type that represents a possible move a player can perform. The player
can shift a card from one deck to another, flip the stock pile into the waste pile,
and declare Nerts. *)
type move = Shift of card * deck * deck
		| Flip of deck
		| Declare

(*Represents a player's input as a string (e.g. "move King of Hearts from workspace deck
1 to common area"*)
type input = string

(*Represents a player in the nerts game. Store the player's name, workspace,
nerts pile, stock pile, and waste pile.*)
type player = {name : string; 
			workspace : workspace; 
			nerts : nerts; 
			wastePile : wastePile; 
			stockPile : stockPile}

(*FUNCTION DEFINITIONS*)

(*Given a string representing a player's input, returns the move the player 
intends to perform*)
val determineMove : input -> move