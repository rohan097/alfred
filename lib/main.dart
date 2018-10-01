import 'package:flutter/material.dart';
import 'package:alfred/chat_screen.dart';
import 'package:alfred/auth.dart';
import 'package:alfred/root_page.dart';
import 'package:alfred/complaints_screen.dart';
import 'package:alfred/settings_screen_new.dart';
import 'package:alfred/firebase_db.dart';
import 'help_screen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Alfred',
      theme: new ThemeData(
        primaryColor: Color(0xFF092c74),
        accentColor: Color(0xFFC54B25),
      ),
      //home: new MyHomePage(title: 'Chat'),
      home: RootPage(auth: new Auth(), db: new DB()),
      color: Colors.blueGrey[200],
      routes: <String, WidgetBuilder> {
        '/chatPage': (BuildContext context) => new ChatScreen(
          title: 'Chat',
        ),
        '/complaintScreen': (BuildContext context) => new ComplaintScreen(),
        '/settingsScreen': (BuildContext context) => new SettingScreen(),
        '/helpScreen': (BuildContext context) => new HelpScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
