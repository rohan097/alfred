library alfred.globals;

import 'package:alfred/firebase_db.dart';
import 'dart:async';

String firebaseUID;
String firstName;
String lastName;
Map<dynamic, dynamic> address;
String mobileNumber;

Future<String> updateGlobalDataFromInternet(String userID) async {
  BaseDB db = DB();
  print ("Updaing global variables from internet.");
  firebaseUID = userID;
  Map<dynamic, dynamic> data = await db.getUserDetails(userID);
  firstName = data["Name"]["firstName"];
  lastName = data["Name"]["lastName"];
  address = data["Address"];
  mobileNumber = data["Mobile Number"];

  print("Updated set of global variables from internet.");
  return "1";
}

void updateGlobalDataFromDevice(String uid, String fName, String lName) {
  firebaseUID = uid;
  firstName = fName;
  lastName = lName;
  address = {
    "Address": {
      "Address Line 1": "0",
      "Address Line 2": "0",
      "City": "0",
      "Pincode": "0"
    }
  };
  mobileNumber = "0";
}
