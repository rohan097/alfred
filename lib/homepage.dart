import 'package:flutter/material.dart';
import 'package:alfred/auth.dart';
import 'package:alfred/globals.dart' as globals;

class HomePage extends StatelessWidget {
  HomePage({this.auth, this.onSignedOut});

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
      body: Column(
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
                    child: Text('Chat'),
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
                    child: Text('Complaints'),
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
                    child: Text('Settings'),
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
                    child: Text('Help'),
                    onPressed: () {},
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
                child: Text("Logout"),
                onPressed: _signOut,),
            ),
            flex: 1
          )
        ],
      ),
    );
  }
}
