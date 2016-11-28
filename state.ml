open Player
open Deck
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

let rec init_single_common num = 
	if num = 0 then [] 
	else
	[[];[];[];[]]@(init_single_common (num-1))

let init_state (input : string list) = 
	let a = List.map init input in 
	{players=a;commonArea=(init_single_common (List.length input))}

let canDeclare player = 
	if isEmpty player.nerts then true else false

(*
let perform_move  move = 
	match move with
	| Shift (card,deck1,deck2,player) -> 
	| _ -> ()
*)
let rec common_area_adder (commonArea : orderedDeck list) card deck_to = 
	match commonArea with
	| h::t -> if h = deck_to then [([card]@deck_to)]@t else h::(common_area_adder t card deck_to)
	| [] -> []

let shift_common_helper state deck_from deck_to player = 
	if size deck_from = 0 then () 
	else 
	let card = List.hd deck_from in 
	if can_add_card_common card deck_to then 
	let () = shift_helper_common player deck_from  deck_to player in 
	let common = common_area_adder state.commonArea card deck_to in 
	let () = state.commonArea <- common in 
	player.points <- (player.points + 1)
	else ()


	
let move state move = 
	match move with
	| Shift_Common (deck_from,deck_to,player) -> let () = shift_common_helper state deck_from deck_to player in 
												 state
	| Shift (card,deck1,deck2,player) -> let () = if size deck1 != 0 then 
								  shift_helper player card deck1 deck2
							      else ()  in 
								  state
	| Flip player -> let () = flip player in 
			  		 state
	| Shuffle -> let players = List.map (fun player -> (player.stockPile <- (shuffle player.stockPile))) state.players in 
				state
	| Declare -> state





