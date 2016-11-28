(*Implements a deck as well as the functions required to manipulate
a deck, including shuffling, adding, and removing cards.*)


(*TYPE DEFINITIONS*)

(*Variant type that represents the rank of a card (e.g. King, 4, etc.)*)
type rank = Number of int | Jack | Queen | King | Ace

(*Variant type that represents the suit of a card*)
type suit = Clubs | Hearts | Diamonds | Spades

(*Represent a card's rank, suit, and owner (as there will be
a deck for each player)*)
type card = {rank : rank;
			suit : suit}

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


(*FUNCTION DEFINITIONS*)

(*Returns the number of cards in a deck*)
val size : deck -> int

(*Returns true if the deck contains no cards, and false otherwise.*)
val isEmpty : deck -> bool

(*Given a deck, returns true if the deck is ordered like a solitaire
deck, and false otherwise.*)
val isSolitaire : deck -> bool

(*Given a deck, returns true if the deck is an ordered deck, and false
otherwise*)
val isOrdered : deck -> bool

(*Given a deck, shuffles the cards of the deck randomly and gives the
newly shuffled deck containing the same cards.*)
val shuffle : deck -> deck

(*Given a deck and a card to add, adds the card to the top of the deck*)
val addCard : deck -> card -> deck

(*Given a deck and a card to remove, removes the card from the top of the
deck. If the card is not on the top of the deck, this function will raise
Failure.*)
val removeCard : deck -> card -> deck

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