import 'package:flutter/material.dart';
import 'package:alfred/firebase_db.dart';


class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(0.0),
              highlightColor: Color(0xFFC54B25),
              splashColor: Color(0xFFC54B25),
              onTap: () {
                Navigator.of(context).pushNamed('/settingScreen');
              },
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.phone,
                        size: 45.0,
                      ),
                    ),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Add/ Edit phone number.",
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            "This number will be used to contact you in the event our technician needs to reach you.",
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            flex: 1,
          ),
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(0.0),
              highlightColor: Color(0xFFC54B25),
              splashColor: Color(0xFFC54B25),
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.map,
                        size: 45.0,
                      ),
                    ),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Edit addresss.",
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            "Change your home address.",
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            flex: 1,
          ),
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(0.0),
              highlightColor: Color(0xFFC54B25),
              splashColor: Color(0xFFC54B25),
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.phone_android,
                        size: 45.0,
                      ),
                    ),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Do something else.",
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis purus.",
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            flex: 1,
          ),
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(0.0),
              highlightColor: Color(0xFFC54B25),
              splashColor: Color(0xFFC54B25),
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.phone_android,
                        size: 45.0,
                      ),
                    ),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Maybe, do something different!",
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis purus.",
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }
}
