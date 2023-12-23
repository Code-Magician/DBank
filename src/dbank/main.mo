import Debug "mo:base/Debug";

actor DBank {
  var currValue = 200;

  // QUERY Functions 
  // ( If we are not changing state of any variable. ) They are faster.
  public query func checkBalance(): async Nat {
    Debug.print(debug_show(currValue));
    return currValue;
  };

  // UPDATE Functions 
  // ( If we are changing state of any variable. ) They are slower because we have to write the data on the blockchain.
  // We can run the below 2 function using the command "dfx canister call <project_name> <func_name> <arguments_to_be_sent_to_func>".
  // Or we can use candid frontend to call the functions to setup visit { https://internetcomputer.org/docs/current/developer-docs/backend/candid/candid-howto };
  public func topUp(amount : Nat) {
    currValue += amount;

    Debug.print(debug_show (currValue));
  };

  // if else in motoko are expressions not statements.
  public func withdraw(amount : Nat) {
    currValue -= if (currValue >= amount) { amount } else { currValue };

    Debug.print(debug_show(currValue));
  };
};
