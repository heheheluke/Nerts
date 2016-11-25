open deck

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

(*Represents the workspace of a player, the four solitaireDecks
that a player is allowed to manipulate.*)
type workspace = (solitaireDeck list)

(*Represents a player's nerts pile, the cards the player is required
to get rid of before being able to declare "Nerts."*)
type nerts = deck

(*Represents a player's waste pile, the pile of cards that has already
been flipped over from the stock pile.*)
type wastePile = deck

(*Represents a player's stack pile, the cards the player has available
to flip over into the waste pile.*)
type stockPile = deck

(*Represents a player in the nerts game. Store the player's name, workspace,
nerts pile, stock pile, and waste pile.*)
type player = {name : string; 
			workspace : workspace; 
			nerts : nerts; 
			wastePile : wastePile; 
			stockPile : stockPile}
