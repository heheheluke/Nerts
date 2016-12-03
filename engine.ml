open Mutex

(* The mutex for the Engine. Needs to be a global variable. *)
let mut = Mutex.create ()

(* The state of the game. Also needs to be global, so multiple threads can
 * make changes to it. *)
let state = ref 0

(* Delay threads based on which player is calling *)
let chooseMove player = if player = "AI1" then Thread.delay 0.2 else if
  player = "AI2" then Thread.delay 0.4 else if player = "AI3"
  then Thread.delay 0.1 else (); "Flip"

(* Responsible for changing the state <state>. *)
let rec editState player move =
  Mutex.lock mut;
  (* change state. State should be a global variable. *)
  if !state = 100 then () else state := !state + 1;
  Mutex.unlock mut;
  print_int !state;
  print_string player;
  if !state = 100 then () else editState player (chooseMove player)


(* Given a game state <state>, initializes the players and lets them pick their
 * moves. *)
let rec game config =
  (*if config = ____ then *)
  ignore (Thread.create (editState "AI1") (chooseMove "AI1"));
  ignore (Thread.create (editState "AI2") (chooseMove "AI2"));
  ignore (Thread.create (editState "AI3") (chooseMove "AI3"));
  ignore (Thread.create (editState "Player") (chooseMove "Player"));
  state