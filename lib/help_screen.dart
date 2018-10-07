import 'package:flutter/material.dart';
import 'package:alfred/firebase_db.dart';
import 'dart:async';
import 'package:alfred/globals.dart' as globals;

final scaffoldKey = GlobalKey<ScaffoldState>();

List<String> questions = [
  "What is Alfred?",
  "How do I use this app?",
  "I don't know what to say!",
  "Why does it not recognise what I'm saying?",
  "What are the different stages of a ticket?"
];
List<Widget> answers = [
  Text(
    "Named after Batman's  legendary butler, Alfred is your own personal assisstant. Alfred is here to help you with your GE Appliance. "
        "In the unlikely event of you facing trouble with your product, you can use this application to schedule a house call or an appoinment "
        "to speak with one of our agents.",
    textAlign: TextAlign.justify,
    style: TextStyle(
      fontWeight: FontWeight.w500,
    ),
  ),
  Text(
    "To create a ticket, click on the \"Chat\" button on the Homepage. This will bring you to the page where you can talk to Alfred, our "
        "in-house AI. He would help you with the process.",
    textAlign: TextAlign.justify,
  ),
  RichText(
    textAlign: TextAlign.justify,
    text: TextSpan(
      style: TextStyle(
        color: Colors.black,
        fontSize: 14.0,
        fontFamily: 'OpenSans'
      ),
      children: [
        TextSpan(
          text: "Here's a list of commands to get you started: \n\n",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text:
              "-> \"I would like to create a ticket.\" : This gets you started with creating your own ticket.\n",
        ),
        TextSpan(
          text: "-> \"I want to see my tickets.\": Shows you all the tickets.\n",
        ),
        TextSpan(
          text:
              "-> \"I want to choose the time.\" : This lets you choose or change the time of a house call. \n",
        ),
        TextSpan(
          text:
              "-> \"I want to delete/cancel my ticket.\" : This deletes a ticket from your account. Once this is done, it cannot be undone.\n",
        ),
        TextSpan(
          text:
              "\nThese are just some of the commands. Please note, slang or verbose language would likely result in errors. So try to be concise. Over time, the system would improve.",
        ),
      ],
    ),
  ),
  Text(
    "In its current version, the system supports only a limited vocabulary. So, please try and keeps things simple. But by all means, do experiment and push Alfred to his limits!",
    textAlign: TextAlign.justify,
  ),
  Text(
    "In the Tickets Page of your app, you will be able to see the progress of you ticket.\n"
        "* Under Review: Your ticket has been submitted. Based on the requirements and location, our team will decide some slots for you choose from.\n"
        "* Agent Allotted: An agent has been assigned to this ticket. You would have to choose from among three time slots for the visit. \n"
        "* Resolved: Your issue has been fixed. Once done, the ticket is considered closed. If an issue arises again, you would need to open another ticket.\n",
    textAlign: TextAlign.justify,
  ),
];

class HelpScreen extends StatefulWidget {
  HelpScreenState createState() => HelpScreenState();
}

class HelpScreenState extends State<HelpScreen> {
  /*List<MyPanel> _items = <MyPanel>[
    MyPanel(
        question: questions[0],
        answer: answers[0],
    ),
    MyPanel(
        question: questions[1],
        answer: answers[1],
    ),
  ];*/

  final _items = List<MyPanel>.generate(questions.length,
      (i) => MyPanel(question: questions[i], answer: answers[i]));

  @override
  Widget build(BuildContext context) {
    print("Building help screen.");
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.blueGrey[200],
      appBar: AppBar(
        title: Text("Help"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  ExpansionPanelList(
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        _items[index].isExpanded = !_items[index].isExpanded;
                      });
                    },
                    children: _items.map(
                      (MyPanel item) {
                        return new ExpansionPanel(
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return item.panelHeader();
                            },
                            isExpanded: item.isExpanded,
                            body: item.panelBody());
                      },
                    ).toList(),
                  ),
                ],
              ),
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}

class MyPanel {
  bool isExpanded;
  Widget header;
  Widget body;
  final String question;
  Widget answer;

  Widget panelHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        question,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget panelBody() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      child: answer,
    );
  }

  MyPanel({this.isExpanded: false, this.question, this.answer});
}
