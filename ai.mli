open State
open Player

(*Implements the AI for a player for the game Nerts*)


(*TYPE DEFINITIONS*)

(*The difficulty of the AI, implemented as an int within a certain range*)
type difficulty = int 

(*FUNCTION DEFINITIONS*)

(*Given a state of the game, return a list of possible moves the AI can 
perform.*)
val getAllMoves : state -> move list

(*Given the state of the game, returns the move that the AI would perform.*)
val chooseMove : state -> move

(*Given a Nerts game state, compute the score that corresponds to how "good" the
state is for the AI; the higher the number, the better the state.*)
val compute : state -> int