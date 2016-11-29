#load "graphics.cma"
open State
open Graphics



(* README *)
(* drawplayers is the main function responsible for drawing information onto
 * the graphics screen. Currently, it only draws the name of the players, but
 * adding the other information isn't difficult. There are just many ways to do
 * it and we should decide which way we want to do it. Also, without being able
 * to draw cards from jpgs or pngs, we also need to decide how we want to
 * represent all of the cards. *)



(* A helper function which draws the graphics window with information related
 * to <players>. <size> is used to know how much space there needs to be in
 * between each player. (<size> is the number of players) *)
let rec drawplayers players size = match players with
  | [] -> ()
  | h::t -> rmoveto (((size_x ())/size)) 0;
    draw_string h.name; drawplayers t size

(* Opens a new graphics window and draws it based off of the information in
 * <state>. *)
let initGui state = open_graph ""; let num_play = List.length state.players in
  moveto (-((size_x ())/(num_play))) 0;
  drawplayers state.players num_play

(* Behaves the same as initGui, except instead of opening a new graphics window
 * it clears the current one and updates it with <state>. *)
let updateGui state = clear_graph (); let num_play = List.length state.players in
  moveto (-((size_x ())/(num_play))) 0;
  drawplayers state.players num_play

(* Clears the current graphics window and draws "Game Over" in the center of the
 * graphics window. *)
let closeGui state = clear_graph ();
  set_text_size = 20;
  moveto (((size_x ()) / 2) - ((fst (text_size "Game Over")) / 2))
  ((size_y ()) / 2); draw_string "Game Over"
