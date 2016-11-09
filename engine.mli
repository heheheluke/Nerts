open State
open Player

(*Implements the game engine that updates the state of the game,
as well as determining whether or not a move is legal/illegal.*)

(*TYPE DEFINITIONS*)

(*Type synonym that represents the initial game state, such as
number of players and difficulty of the players.*)
type config = string list

(*FUNCTION DEFINITIONS*)

(*Given a state and a move to perform, determines whether or not
the move is legal*)
val isLegalMove : state -> move -> bool

(*Given a state a move to perform that is determined to be legal, and
the player performing the move, returns a new state with the move 
performed.*)
val performMove : state -> move -> player -> state

(*Initializes the game state. Given a configuration (that represents,
for example, the number of players and their difficulties), returns
the initial game state.*)
val main : config -> state