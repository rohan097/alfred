import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'globals.dart' as globals;

abstract class BaseDB {
  Future<Map<dynamic, dynamic>> getUserDetails(String userId);

  Future<Map<dynamic, dynamic>> createUserDetails(String userId,
      String userName, String email);

  Future<String> updateUserAddress(Map<dynamic, dynamic> newValue);

  Future<String> updateUserMobile(String newValue);
}

class DB implements BaseDB {
  final firebaseDB = FirebaseDatabase.instance.reference();

  Future<Map<dynamic, dynamic>> getUserDetails(String userId) async {
    print("Getting user details");
    print("User id $userId");
    Map<dynamic, dynamic> userDetails = await firebaseDB
        .child("user_data")
        .child(userId)
        .once()
        .then((DataSnapshot snapshot) {
      print("Getting user details. Snapshot val: ${snapshot.value}");
      return snapshot.value;
    });
    return userDetails;
  }

  Future<Map<dynamic, dynamic>> createUserDetails(String userId,
      String userName, String email) async {
    String firstName, lastName;
    try {
      firstName = userName.split(' ')[0];
      lastName = userName.split(' ')[1];
    }
    catch (RangeError) {
      firstName = userName.split(' ')[0];
      lastName = " ";
    }
    Map<dynamic, dynamic> data = {
      "Name": {
        "firstName": firstName,
        "lastName": lastName,
      },
      "Email": email,
      "Address": {
        "Main": "0",
        "Pincode": "0"
      },
      "Mobile Number": "0",
      "Complaints": "0"
    };
    await firebaseDB.child("user_data").child(userId).set(data);
    return data;
  }

  Future<String> updateUserAddress(Map<dynamic, dynamic> newValue) async {
    print("in firebase... going to update address");
    print("${globals.firebaseUID}");
    await firebaseDB.child("user_data").child(globals.firebaseUID).child(
        "Address").set(newValue);
    return "Done";
  }

  Future<String> updateUserMobile(String newValue) async {
    print("in firebase... going to update mobile");
    print("${globals.firebaseUID}");
    await firebaseDB.child("user_data").child(globals.firebaseUID).child(
        "Mobile Number").set(newValue);
    return "Done";
  }

}
