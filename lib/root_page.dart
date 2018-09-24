import 'package:flutter/material.dart';
import 'package:alfred/auth.dart';
import 'package:alfred/login_screen.dart';
import 'package:alfred/homepage.dart';
import 'package:alfred/firebase_db.dart';
import 'globals.dart' as globals;
import 'dart:async';

enum AuthStatus { signedIn, notSignedIn }

class RootPage extends StatefulWidget {
  RootPage({this.auth, this.db});

  final BaseAuth auth;
  final BaseDB db;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthStatus _authStatus = AuthStatus.notSignedIn;

  @override
  void initState() {

    print ("Initialising State in Root Page.");
    widget.auth.currentUser().then((userId) {
      if (userId == null) {
        setState(() {
          print ("User id is null. Nobody is logged in.");
          _authStatus = AuthStatus.notSignedIn;
        });
      } else {
        print("In root page. The user id currently logged in is: $userId");
        globals.updateGlobalDataFromInternet(userId).then((value) {
          setState(() {
            _authStatus = AuthStatus.signedIn;
          });
        });
      }
    });
    super.initState();
  }

  void _signedIn() async {
    setState(() {
      print ("Setting state as signedIn");
      _authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      _authStatus = AuthStatus.notSignedIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    switch (_authStatus) {
      case AuthStatus.notSignedIn:
        return new LoginScreen(
            auth: widget.auth, onSignedIn: _signedIn, db: widget.db);
      case AuthStatus.signedIn:
        return HomePage(
          auth: widget.auth,
          onSignedOut: _signedOut,
        );
    }
  }
}
