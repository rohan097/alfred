import 'package:flutter/material.dart';
import 'package:alfred/auth.dart';
import 'package:alfred/firebase_db.dart';
import 'globals.dart' as globals;

class LoginScreen extends StatefulWidget {
  LoginScreen({this.auth, this.db, this.onSignedIn});

  final BaseAuth auth;
  final BaseDB db;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}


enum FormType { login, register }

class _LoginScreenState extends State<LoginScreen> {
  String _email;
  String _password;
  String _name;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  FormType _formType = FormType.login;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          try{
            String userId =
            await widget.auth.signInWithEmailAndPassword(_email, _password);
            globals.firebaseUID = userId;
            print("Signing in. User id = $userId");
            globals.updateGlobalDataFromInternet(userId).then((val) {
              widget.onSignedIn();
            });
          }
          catch (e) {
            SnackBar snackBar = new SnackBar(content: Text("Invalid credentials"));
            scaffoldKey.currentState.showSnackBar(snackBar);
          }

        } else {
          String userId = await widget.auth
              .createUserWithEmailAndPassword(_email, _password);
          Map<dynamic, dynamic> userDetails = await widget.db
              .createUserDetails(userId, _name, _email)
              .then((userID) {
            print('Registered: $userId');
              widget.onSignedIn();
          });
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  void moveToRegister() {
    setState(() {
      formKey.currentState.reset();
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    setState(() {
      formKey.currentState.reset();
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF092c74),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/alfred.png',
                  height: 128.0,
                  width: 128.0,
                  fit: BoxFit.fill,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: buildInputs() + buildSubmitButtons(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildInputs() {
    if (_formType == FormType.register) {
      return [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextFormField(
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: Color(0xFFC54B25),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: Color(0xFFC54B25),
                  ),
                ),
                prefixIcon: Icon(
                  Icons.email,
                  color: Color(0xFFC54B25),
                ),
                hintText: 'Enter your email',
                hintStyle: TextStyle(
                  color: Colors.white,
                )),
            validator: (value) =>
                value.isEmpty ? 'Email cannot be empty' : null,
            onSaved: (value) => _email = value,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextFormField(
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(
                  color: Color(0xFFC54B25),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(
                  color: Color(0xFFC54B25),
                ),
              ),
              prefixIcon: Icon(
                Icons.lock_outline,
                color: Color(0xFFC54B25),
              ),
              hintText: 'Choose a password',
              hintStyle: TextStyle(
                color: Colors.white,
              ),
            ),
            obscureText: true,
            validator: (value) => value.isEmpty
                ? 'Password cannot be empty'
                : value.length < 6
                    ? 'Password must be greater than 6 character'
                    : null,
            onSaved: (value) => _password = value,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextFormField(
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: Color(0xFFC54B25),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: Color(0xFFC54B25),
                  ),
                ),
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: Color(0xFFC54B25),
                ),
                hintText: 'Enter your name',
                hintStyle: TextStyle(
                  color: Colors.white,
                )),
            validator: (value) => value.isEmpty ? 'Name cannot be empty' : null,
            onSaved: (value) => _name = value,
          ),
        ),
      ];
    } else {
      return [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextFormField(
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: Color(0xFFC54B25),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: Color(0xFFC54B25),
                  ),
                ),
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: Color(0xFFC54B25),
                ),
                hintText: 'Enter your email',
                hintStyle: TextStyle(
                  color: Colors.white,
                )),
            validator: (value) =>
                value.isEmpty ? 'Email cannot be empty' : null,
            onSaved: (value) => _email = value,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextFormField(
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock_outline,
                color: Color(0xFFC54B25),
              ),
              hintText: 'Enter your password',
              hintStyle: TextStyle(
                color: Colors.white,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(
                  color: Color(0xFFC54B25),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(
                  color: Color(0xFFC54B25),
                ),
              ),
            ),
            obscureText: true,
            validator: (value) =>
                value.isEmpty ? 'Password cannot be empty' : null,
            onSaved: (value) => _password = value,
          ),
        ),
      ];
    }
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return [
        OutlineButton(
          child: Text(
            'Login',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          onPressed: validateAndSubmit,
          highlightColor: Colors.blueGrey,
        ),
        FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Text(
            "Don't have an account yet? Create one.",
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
          onPressed: moveToRegister,
        ),
      ];
    } else {
      return [
        OutlineButton(
          child: Text(
            'Create an account.',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          highlightColor: Colors.blueGrey,
          onPressed: validateAndSubmit,
        ),
        FlatButton(
          child: Text(
            'Already have an account? Login.',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          onPressed: moveToLogin,
        ),
      ];
    }
  }
}
