import Debug "mo:base/Debug";

actor DBank {
  var first = 200;  // Defining a variable.
  first := 200; // Assigning a variable.

  let second = 134241;  // Defining a const.

  // # is used to concatenate 2 things of same type.
  // Debug.print() only takes strings to print.
  // debug_show() converts the number to string. Nat.to_Text() does the same.
  Debug.print("Variable : " # debug_show (first)); 
  Debug.print("Constant : " # debug_show (second));
};
