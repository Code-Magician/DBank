import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";
import Int "mo:base/Int";

actor DBank {
  // It is now a persisted variable.
  // If we deploy the app again the value of this variable will not be set to 200 rather it will be remain same as it was in the last deploy after performing all the actions.
  stable var currValue : Float = 200;
  stable var interest : Float = 1.0;
  stable var startTime : Int = Time.now();

  // QUERY Functions
  // ( If we are not changing state of any variable. ) They are faster.
  public query func checkBalance() : async Float {
    // Debug.print(debug_show(currValue));
    return currValue;
  };

  // UPDATE Functions
  // ( If we are changing state of any variable. ) They are slower because we have to write the data on the blockchain.
  // We can run the below 2 function using the command "dfx canister call <project_name> <func_name> <arguments_to_be_sent_to_func>".
  // Or we can use candid frontend to call the functions to setup visit { https://internetcomputer.org/docs/current/developer-docs/backend/candid/candid-howto };
  public func topUp(amount : Float) {
    currValue += amount;

    // Debug.print(debug_show (currValue));
  };

  // if else in motoko are expressions not statements.
  public func withdraw(amount : Float) {
    currValue -= if (currValue >= amount) { amount } else { currValue };

    // Debug.print(debug_show(currValue));
  };

  public func compound() {
    let currTime : Int = Time.now();
    let timeElapsedInSeconds : Float = Float.fromInt(currTime - startTime) / 1000000000.0;

    currValue := currValue * (1.0 + interest/100.0) ** timeElapsedInSeconds;

    startTime := Time.now();
  };
};
