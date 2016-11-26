module Deck = struct
(*Variant type that represents the rank of a card (e.g. King, 4, etc.)*)
type rank = Number of int | Jack | Queen | King | Ace

(*Variant type that represents the suit of a card*)
type suit = Clubs | Hearts | Diamonds | Spades

(*Represent a card's rank, suit, and owner (as there will be
a deck for each player)*)
type card = {rank : rank; suit : suit}

(*Represent a deck of cards with no restrictions as to how the
cards are ordered.*)
type deck = card list

(*Represents a deck of cards that would form the common area of the
Nerts game. An ordered deck is a deck where the ranks of the cards are
increasing from the bottom to the top, and the suit of all the cards
are the same. *)
type orderedDeck = deck * suit

(*Represents a deck of cards that would compose the workspace of a
player. A solitaire deck is a deck where the ranks of the cards decrease
from bottom to top (e.g. King, Queen, Jack, ...) and the "color" of the
cards alternates (e.g. King of Hearts, Queen of Spades, Jack of Diamonds, ...)
Hearts and Diamonds form the "red" color, while Spades and Clubs form
the "black" color.*)
type solitaireDeck = deck

let deck = 
[{rank= Number 2;suit=Clubs};
{rank= Number 3;suit=Clubs};
{rank= Number 4;suit=Clubs};
{rank= Number 5;suit=Clubs};
{rank= Number 6;suit=Clubs};
{rank= Number 7;suit=Clubs};
{rank= Number 8;suit=Clubs};
{rank= Number 9;suit=Clubs};
{rank= Number 10;suit=Clubs};
{rank= Jack;suit=Clubs};
{rank= Queen;suit=Clubs};
{rank= King;suit=Clubs};
{rank= Ace;suit=Clubs};
{rank= Number 2;suit=Hearts};
{rank= Number 3;suit=Hearts};
{rank= Number 4;suit=Hearts};
{rank= Number 5;suit=Hearts};
{rank= Number 6;suit=Hearts};
{rank= Number 7;suit=Hearts};
{rank= Number 8;suit=Hearts};
{rank= Number 9;suit=Hearts};
{rank= Number 10;suit=Hearts};
{rank= Jack;suit=Hearts};
{rank= Queen;suit=Hearts};
{rank= King;suit=Hearts};
{rank= Ace;suit=Hearts};
{rank= Number 2;suit=Diamonds};
{rank= Number 3;suit=Diamonds};
{rank= Number 4;suit=Diamonds};
{rank= Number 5;suit=Diamonds};
{rank= Number 6;suit=Diamonds};
{rank= Number 7;suit=Diamonds};
{rank= Number 8;suit=Diamonds};
{rank= Number 9;suit=Diamonds};
{rank= Number 10;suit=Diamonds};
{rank= Jack;suit=Diamonds};
{rank= Queen;suit=Diamonds};
{rank= King;suit=Diamonds};
{rank= Ace;suit=Diamonds};
{rank= Number 2;suit=Spades};
{rank= Number 3;suit=Spades};
{rank= Number 4;suit=Spades};
{rank= Number 5;suit=Spades};
{rank= Number 6;suit=Spades};
{rank= Number 7;suit=Spades};
{rank= Number 8;suit=Spades};
{rank= Number 9;suit=Spades};
{rank= Number 10;suit=Spades};
{rank= Jack;suit=Spades};
{rank= Queen;suit=Spades};
{rank= King;suit=Spades};
{rank= Ace;suit=Spades}]


(* Taken from internet need to creat own. *)
let shuffle d =
    let a = List.map (fun c -> (Random.bits (), c)) d in 
    let temp = List.sort compare a in 
    List.map (fun (a,b) -> b) temp

(*FUNCTION DEFINITIONS*)
(* MEthods that have come up after  doing shit 
TO Dos:
Add pile to main 
Add work pile method 
*)
(*Returns the number of cards in a deck*)
let size deck = 
	(List.length deck) 


(*Returns true if the deck contains no cards, and false otherwise.*)
let isEmpty  deck = 
	if size deck = 0 
	then true 
 	else false

let rank_convert rank = 
	match  rank with
	| Number x -> x
	| Jack -> 11
	| Queen -> 12
	| King -> 13
	| Ace  -> 14
	
let is_red suit = 
	match suit with
	| Hearts | Diamonds -> false
	| _ -> true


let can_add_card deck card = 
	if isEmpty deck 
	then true 
	else 
	let dcard = List.hd deck in 
	if (is_red card.suit) != (is_red dcard.suit) &&  
	((rank_convert dcard.rank)) = ((rank_convert card.rank)+1)
	then true
	else 
	false

let can_add_card_common deck card = 
	if size deck = 13
	then false 
	else if (card.rank = Ace) && isEmpty deck then 
	true
	else 
	let dcard = List.hd deck in 
	if ((rank_convert dcard.rank) = ((rank_convert card.rank)-11)) &&
	dcard.suit = card.suit then true
	else
	false

(*
Tranpoting multpile decks 
*)
let can_add_deck deck_from deck_to = 
	let lower = List.nth deck_from  ((size deck_from)-1) in 
	can_add_card deck_to lower

let rec split_list list2 num = 
	match list2 with
	| h::t -> if num == 1 then [h] else h::(split_list t (num-1))
	| [] -> []

let rec split_list2 list num = 
	match list with
	| [] -> []
	| h::t -> if num > 0 then split_list2 (List.tl list) (num-1) else list
	

let rec make_work (work_pile : deck) = 
	match work_pile with
	| h::t -> [h]::(make_work t)
	| [] -> []

let addCard_work deck card = 
	if can_add_card deck card then 
	[card]@deck
	else
	deck

let removeCard (deck : deck) card = 
	if size deck = 0 then 
	deck
	else
	let card_compare = List.hd deck in 
	if card_compare != card then deck
 	else 
 	List.tl deck

let combine (deck_from : deck)  deck_to = 
	if size deck_from = 0 then deck_to else
	if size deck_to = 0 then deck_from else
	let bottom = List.nth deck_from ((size deck_from)-1) in 
	if can_add_card deck_to bottom then deck_from@deck_to else
	deck_to

let rec separate_helper (deck : deck) card = 
	match deck with
	| h::t -> if h = card then [h] else
				h::(separate_helper t card) 
	| [] -> []

let separate deck card = 
	if List.mem card deck = false then deck else
	separate_helper deck card


let remove_first deck =
	if size deck > 0 then  List.tl deck else deck
(*)
(*Given two decks a and b, combines the decks so that a goes on top of b,
and gives the newly formed deck. 
For example, if a was the deck: King of Hearts, Queen of Hearts, Jack of Hearts,
from top to bottom, and b was the deck: 10 of Hearts, 9 of Hearts, 8 of Hearts,
then the resulting deck would be: King of Hearts, Queen of Hearts, Jack of Hearts,
10 of Hearts, 9 of Hearts, 8 of Hearts.*)
val combine : deck -> deck -> deck

(*Given a deck and a card, remove the section of the deck from the given card
and above it, returning it as a deck. If the card is not in the deck, this
function will raise Failure.*)
val separate : deck -> card -> deck
*)
end