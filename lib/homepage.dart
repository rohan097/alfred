import 'package:flutter/material.dart';
import 'package:alfred/auth.dart';
import 'package:alfred/globals.dart' as globals;
import 'dart:async';

class HomePage extends StatelessWidget {

  final userID;
  HomePage({this.auth, this.onSignedOut, this.userID});

  final BaseAuth auth;
  final VoidCallback onSignedOut;

  void _signOut() async {
    try {
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          'assets/images/alfred.png',
          fit: BoxFit.fill,
        ),
        title: Text('Alfred'),
      ),
      backgroundColor: Colors.blueGrey[200],
      body: FutureBuilder(
        future: globals.updateGlobalDataFromInternet(userID),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return body(context);
            }
            else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

      }),
    );
  }

  Column body(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Container(
              child: Text(
                "Hello, ${globals.firstName}!",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          flex: 1,
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlineButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.chat_bubble,
                          color: Colors.black54,
                        ),
                      ),
                      Text('Chat',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/chatPage');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlineButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.insert_drive_file,
                          color: Colors.black54,
                        ),
                      ),
                      Text('Tickets',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/complaintScreen');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlineButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.settings,
                          color: Colors.black54,
                        ),
                      ),
                      Text('Settings',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/settingsScreen');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlineButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.help,
                          color: Colors.black54,
                        ),
                      ),
                      Text('Help',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/helpScreen');
                  },
                ),
              ),
            ],
          ),
          flex: 5,
        ),
        Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Text(
                  "Logout",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onPressed: _signOut,),
            ),
            flex: 1
        )
      ],
    );
  }
}
