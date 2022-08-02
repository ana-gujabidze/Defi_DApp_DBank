import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DBank {
  stable var currentValue: Float = 300;
  // currentValue := 300;
  stable var startTime = Time.now();
  // startTime := Time.now();

  public func topUp(amount: Float) {
     currentValue += amount;
     Debug.print(debug_show(currentValue));
  };

  public func withdraw(amount: Float) {
    let tempValue: Float = currentValue - amount;
    if (tempValue >= 0){
      Debug.print(debug_show(tempValue));
    } else {
      Debug.print("Provided number is in the incorrect number range!");
    }
  };

  public query func checkValue(): async Float {
    return currentValue;
  };

  public func compound() {
    let currentTime = Time.now();
    let timeElapsedNS = currentTime - startTime;
    let timeElapsedS = timeElapsedNS / 1000000000;
    currentValue := currentValue * 1.01 ** Float.fromInt(timeElapsedS);
    startTime := currentTime;
  };

}