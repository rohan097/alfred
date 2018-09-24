import 'package:firebase_auth/firebase_auth.dart';
import 'package:alfred/globals.dart' as globals;
import 'dart:async';

abstract class BaseAuth {

  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
  Future<void> signOut();

}

class Auth implements BaseAuth {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      return user.uid;
    }
    catch (e) {
      print ("Exception when signing in: $e");
      throw Exception(e);
    }
  }

  Future<String> createUserWithEmailAndPassword(
      String email, String password) async {
    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(), password: password);
    return user.uid;
  }

  Future<String> currentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    if (user == null)
        return null;
    else {
      return user.uid;
    }
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

}
