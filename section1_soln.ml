(* CS51 Section 1: Intro to ML
 *
 * Exercises: The purpose of these exercises is to help you start
 * getting comfortable with Ocaml.  The focus is on pattern matching,
 * list operations, and a bit of basic arithmetic.
 *
 * A goal throughout the semester will be writing code that's clear,
 * concise, and beautiful -- not just correct.  Try to make your
 * solutions as simple as possible.  Once you have a version that works,
 * look for ways to simplify it. *)


(*
......................................................................
Exercise 8: Define a function that returns the maximum element in an
integer list, or None if there are no elements in the list.
......................................................................
*)

let rec max_list (lst : int list) : int option =
  match lst with
  | [] -> None
  | head :: tail ->
     let max_tail = max_list tail in
     match max_tail with
     | None -> Some head
     | Some max_elt ->
	if head > max_elt then Some head else max_tail ;;

(*
......................................................................
Exercise 9: Define a function zip, that takes two int lists and
returns a list of pairs of ints, one from each of the two argument
lists. Make sure that the function handles cases of mismatched list
lengths by returning None in that case. For example, zip [1;2;3]
[4;5;6] should evaluate to Some [(1, 4); (2, 5); (3, 6)].

Why wouldn't it be possible, in cases of mismatched length lists, to
just pad the shorter list with, say, false values, so that,
zip [1] [2; 3; 4] = [(1, 2); (false, 3); (false, 4)]?
......................................................................  
*)

let rec zip (x : int list) (y : int list) : ((int * int) list) option =
  match (x, y) with
  | ([], []) -> Some []
  | (xhd :: xtl, yhd :: ytl) ->
     (match zip xtl ytl with
      | None -> None
      | Some ztl -> Some ((xhd, yhd) :: ztl))
  | (_, _) -> None ;;

(*
......................................................................
Higher-order functions: functions taking functions as arguments!


......................................................................  
*)
