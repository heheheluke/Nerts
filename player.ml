module  Player = struct
open Deck

(*Implements a single player in the game Nerts, as well as the
actions a player can perform*)

(*TYPE DEFINITIONS*)

(*Variant type that represents a possible move a player can perform. The player
can shift a card from one deck to another, flip the stock pile into the waste pile,
and declare Nerts. *)
type move = 
		| Shift_Common of deck 
		| Shift of card * deck * deck 
		| Flip 
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
			mutable points : int;
			mutable workspace1 : deck; 
			mutable workspace2 : deck; 
			mutable workspace3 : deck; 
			mutable workspace4 : deck; 
			mutable nerts : nerts; 
			mutable wastePile : wastePile; 
			mutable stockPile : stockPile}
		
let init name = 
	let s = shuffle deck in 
	let nerts_pile = split_list s 13 in 
	let other = split_list2 s 13 in 
	let work_pile = split_list other 4 in 
	let useing = split_list2 other 4 in 
	let workspace1 = List.nth work_pile 0 in 
	let workspace2 = List.nth work_pile 1 in 
	let workspace3 = List.nth work_pile 2 in 
	let workspace4 = List.nth work_pile 3 in 
	{name=name;
	points=(-26);
	workspace1=[workspace1]; 
	workspace2=[workspace2]; 
	workspace3=[workspace3]; 
	workspace4=[workspace4]; 
	nerts=nerts_pile; 
	wastePile=[]; 
	stockPile=useing}


let flip player = 
	let a = size player.stockPile in 
	if a > 0
	then 
	let () = player.stockPile <- split_list2 player.stockPile (min 3 a) in 
	player.wastePile <- (split_list player.stockPile (min 3 a))@(player.wastePile)
	else
	let temp = List.rev player.wastePile in 
	let () = player.wastePile <- [] in 
	player.stockPile <- temp

(*
let to_workspace_helper player card deck1 deck2 = 
		let first = List.hd player.nerts_pile in 
		let last = List.nth player.nerts_pile ((size player.nerts_pile)-1) in 
		if card = first then 
			if can_add_card (List.nth player.workspace deck2) card then 
			let temp = player.workspace in 
			let () = player<- addCard_work (List.nth player.workspace deck2) card in 
			player.nerts_pile <- List.tl player.nerts_pile 
			else () 
		else if card = last then 
			if can_add_card (List.nth player.workspace deck2) card then 
			let () =(List.nth player.workspace deck2) <- can_add_card (List.nth player.workspace deck2) card in 
			player.nerts_pile <- split_list player.nerts_pile ((size nerts_pile)-1)
			else ()
		else ()

let shift_helper player card deck1 deck2 = 
	if deck1 = 4 then 
		if size player.nerts_pile = 0 then ()
		else if deck2 >= 0 %% deck2 <= 3 then to_workspace_helper player card deck1 deck2
		else ()
	else ()
	
	else if deck1 >= 0 %% deck1 <= 3 then 
		if deck2 >= 0 %% deck2 <= 3 then 


*)
let add_card_heleper player card deck2 = 
	if deck2 = player.workspace1 then player.workspace1 <- [card]@player.workspace1
	else if deck2 = player.workspace2 then  player.workspace2 <- [card]@player.workspace2
	else if deck2 = player.workspace3 then  player.workspace3 <- [card]@player.workspace3
    else if deck2 = player.workspace4 then player.workspace4 <- [card]@player.workspace4
	else  ()

let shift_helper player card deck1 deck2 = 
	if deck1 = player.workspace1 then 
						if List.hd deck1 = card && can_add_card deck2 card then 
					    let () = player.workspace1 <- List.tl player.workspace1 in 
					    add_card_heleper player card deck2
					else () 
	else if deck1 = player.workspace2 then 
					if List.hd deck1 = card && can_add_card deck2 card then 
					    let () = player.workspace2 <- List.tl player.workspace2 in 
					    add_card_heleper player card deck2
					else () 
	else if deck1 = player.workspace3 then 
					if List.hd deck1 = card && can_add_card deck2 card then 
					    let () = player.workspace3 <- List.tl player.workspace3 in 
					    add_card_heleper player card deck2
					else () 
	else if deck1 = player.workspace4 then 
					if List.hd deck1 = card && can_add_card deck2 card then 
					    let () = player.workspace4 <- List.tl player.workspace4 in 
					    add_card_heleper player card deck2
					else () 
	else if deck1 = player.wastePile then 
					if List.hd deck1 = card && can_add_card deck2 card then 
					    let () = player.wastePile <- List.tl player.wastePile in 
					    add_card_heleper player card deck2
				   else () 
	else if deck1 = player.nerts then 
					if List.hd deck1 = card && can_add_card deck2 card then 
					    let () = player.nerts <- List.tl player.nerts in 
					    let () = player.points <- (player.points + 2) in 
					    add_card_heleper player card deck2
					   (*
					else if (List.nth deck1 ((size deck1)-1) = card && can_add_card deck2 card then 
						let () = player.nerts_pile <- List.tl player.nerts_pile in 
					    add_card_heleper player card deck2
					*)
	else () 


end
