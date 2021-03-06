(* CS51 Section 1: Intro to ML & Git
 *
 * Goals
 * Git: gain familiarity with the basics of Git (see Git handout)
 *
 * ML: practice pattern-matching, identifying types, writing
 *     basic functions in OCaml, and using the List module. We will
 *     review options, currying, higher-order functions and 
 *     anonymous functions.
 *
 * A goal throughout the semester will be writing code that's clear,
 * concise, and beautiful -- not just correct.  Try to make your
 * solutions as simple as possible.  Once you have a version that works,
 * look for ways to simplify it. *)

(* Git commands to know:
 * git clone [bitbucket repo ssh link] [local directory name]
 * git pull
 * git status
 * git add [filename1] [filename2] ... or git add -A
 * git commit -am [commit message]
 * git log
 * git push
 * git show
 *
 * Play with Git here: https://github.com/kevinzhang96/git-demo
 *)

(*
......................................................................
Lab Review:

Helpful explanation of the Option types: 
https://piazza.com/class/if9069e9cmd4df?cid=167

max_list: Define a function that returns the maximum element in an
integer list, or None if there are no elements in the list.

zip: Define a function zip, that takes two int lists and
returns a list of pairs of ints, one from each of the two argument
lists. Make sure that the function handles cases of mismatched list
lengths by returning None in that case. For example, zip [1;2;3]
[4;5;6] should evaluate to Some [(1, 4); (2, 5); (3, 6)].

three_zip: Now implement a function three_zip that takes in
three int lists and results a list as a tuple of three ints!
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


let rec zip (x : int list) (y : int list) : ((int * int) list) option =
  match (x, y) with
  | ([], []) -> Some []
  | (xhd :: xtl, yhd :: ytl) ->
     (match zip xtl ytl with
      | None -> None
      | Some ztl -> Some ((xhd, yhd) :: ztl))
  | (_, _) -> None ;;


let rec threezip_short (a:int list) (b:int list) (c:int list) :
    ((int * int * int) list) option =
  match (a, b, c) with
  | ([], [], []) -> Some []
  | (ahd :: atl, bhd :: btl, chd :: ctl) ->
      (match threezip_short atl btl ctl with
       | None -> None
       | Some ntl -> Some ((ahd, bhd, chd) :: ntl))
  | (_,_,_) -> None ;;

(*
......................................................................
Higher-order functions: functions taking functions as arguments!

square: write a function that takes in an integer and returns the square
of that integer

twice: write a function that takes in a function and an integer and
applies that function twice to the integer.

quad: write a function using twice and square that takes in an integer
and returns the fourth power of that integer

List.map and List.fold are some examples of HO functions!

A helpful reference to the List module: 
http://caml.inria.fr/pub/docs/manual-ocaml/libref/List.html
......................................................................  
*)

let square (x : int) : int = x * x ;;

let twice (f : int -> int) (x : int) : int = f (f x) ;; 

let quad (x : int) = twice square ;; 

(*
......................................................................
Anonymous functions: nameless functions!

even: Write a function that returns whether or not a number is even.

even_list: Write a function using List.filter and even that given a list, 
returns a new list with only the even elements of the original list. Given
the list [1; 2; 3; 4], this function should return [2; 4].

even_list_anon: Now, write even_list using an anonymous function, rather
than a call to 'even'.
......................................................................  
*)

let even (x: int) : bool =
    x mod 2 = 0 ;;

let even_list (lst: int list): int list = 
    List.filter even lst ;;

let even_list_anon (lst: int list): int list =
    List.filter (fun x -> x mod 2 = 0) lst ;;

(*
......................................................................
Challenge Problems
......................................................................  
*)

(* Return the min and max of a list, or None if the list is empty. *)
let rec bounds (x:int list) : (int * int) option =
  match x with
  | [] -> None
  | hd :: tl ->
    (match bounds tl with
    | None -> Some (hd, hd)  (* xtl is empty, so xhd is the only element;
                it's the min and the max of x. *)
    | Some (min, max) ->
      Some ((if hd < min then hd else min),
            (if hd > max then hd else max))) ;;

(* Given a matrix (list of lists), return the transpose.
 * The transpose of a matrix interchanges the rows and columns.
 * For example, transpose [[1;2;3];[4;5;6]];;
 * where [1;2;3] and [4;5;6] are the rows,
 * should return [[1;4];[2;5];[3;6]].
 *
 * Hint: write an auxiliary function, split, that
 * returns the first column of a matrix as a list
 * and the rest of the matrix as a list of rows.
 *
 * Behavior of solution is rather odd if m is not a valid matrix.
 *)

let rec split (m:int list list) : (int list * int list list) option =
  match m with
  | [] -> None
  | [] :: ls -> split ls
  | (x :: xs) :: ls ->
    match split ls with
    | Some (c, ls_rest) -> Some (x :: c, xs :: ls_rest)
    | None -> Some ([x], [xs]) ;;

let rec transpose (m:int list list) : int list list =
  match split m with
  | Some (c, m_rest) -> c :: transpose m_rest
  | None -> [] ;;
