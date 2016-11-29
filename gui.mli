open State

(******************************************************************************)
(** Nertz GUI Interface                                                      **)
(******************************************************************************)

(* Uses the OCaml Graphics module. *)

(*FUNCTION DEFINITIONS*)

(* Given an input of the game state, displays a graphic window containing all
   information relevant to the current Nertz game.
 *)
val initGui       : e -> unit

(* Given an input of the game state, updates the GUI to display relevant
   information to the game. Should be called after calling <performMove> in
   engine.mli
 *)
val updateGui     : state -> unit

(* When called, displays information relevant to the state and closes the game.
   For example, if a player has won in <state>, then the GUI will display a
   victory message for the player. If no player has won, the GUI will notify the
   players of this and close the game anyways.
 *)
val closeGui      : state -> unit

(* If a move has been made (determined by the button_down and mouse_pos
 * functions in Graphics), then <getMove> is the move that has been made.
*)

val getMove       : state -> move