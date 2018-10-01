import 'package:flutter/material.dart';
import 'package:alfred/complaint_card.dart';
import 'dart:async';
import 'dart:convert';
import 'globals.dart' as globals;
import 'package:http/http.dart' as http;

bool isBuilt = true;

class ComplaintScreen extends StatelessWidget {
  var _openedComplaints = <Widget>[];
  var _closedComplaints = <Widget>[];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.blueGrey[200],
        appBar: AppBar(
          backgroundColor: Color(0xFF092c74),
          title: Text("Your Tickets"),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: "Open Issues",
              ),
              Tab(
                text: "Closed Issues",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FutureBuilder<List>(
              future: _createCards("Open"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  print("Snapshot has data");
                  return new ListView.builder(
                    itemCount: _openedComplaints.length,
                    itemBuilder: (context, index) => _openedComplaints[index],
                  );
                } else
                  return Center(child: CircularProgressIndicator());
              },
            ),
            FutureBuilder<List>(
              future: _createCards("Closed"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return new ListView.builder(
                      itemCount: _closedComplaints.length,
                      itemBuilder: (context, index) =>
                      _closedComplaints[index]);
                } else
                  return Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Widget>> _createCards(String type) async {
    print("Enteded _createCards");
    String response = await _getData();
    print("Done");
    renderCard(response, type);
    print(_openedComplaints);
    if (type == "Open")
      return _openedComplaints;
    else if (type == "Closed") return _closedComplaints;
  }

  Future _getData() async {
    print("Entered _getData");
    print(globals.firebaseUID);
    var url = 'http://159.89.175.161:3000/getcomplaint/?firebase_uid=' +
        globals.firebaseUID;
    print(url);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print("Response got.");
      return response.body;
    } else {
      throw Exception("Failed to load data. Try again.");
    }
  }

  void renderCard(String response, String type) async {
    try {
      var data = json.decode(response)["Data"];
      var keys = data.keys;
      if (type == "Open") {
        for (var key in keys) {
          var tempTimeSlots = <Map<String, dynamic>>[];
          if (data[key]["Status"] == "Open") {
            for (int i = 1; i <= 3; i++) {
              tempTimeSlots.add(data[key]["Time Slots"]["Slot $i"]);
            }
            _openedComplaints.add(ComplaintCard(
              complaintId: key,
              productType: data[key]["Product Type"],
              issueType: data[key]["Issue Type"],
              description: data[key]["Description"],
              date: data[key]["Date"],
              progress: data[key]["Progress"],
              timeSlot: data[key]["Time Slot Chosen"],
              timeSlots: tempTimeSlots,
              callDetails: data[key]["Details of Call"],
              type: data[key]["Type"],
              status: data[key]["Status"],
            ));
          }
        }
        if (_openedComplaints.length == 0) {
          _openedComplaints.add(Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Looks like you don\'t have any open tickets!",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ));
        }
      } else if (type == "Closed") {
        for (var key in keys) {
          var tempTimeSlots = <Map<String, dynamic>>[];
          if (data[key]["Status"] == "Closed") {
            for (int i = 1; i <= 3; i++) {
              tempTimeSlots.add(data[key]["Time Slots"]["Slot $i"]);
            }
            _closedComplaints.add(ComplaintCard(
              complaintId: key,
              productType: data[key]["Product Type"],
              issueType: data[key]["Issue Type"],
              description: data[key]["Description"],
              date: data[key]["Date"],
              progress: data[key]["Progress"],
              timeSlot: data[key]["Time Slot Chosen"],
              type: data[key]["Type"],
              timeSlots: tempTimeSlots,
              status: data[key]["Status"],
            ));
          }
        }
        if (_closedComplaints.length == 0) {
          _closedComplaints.add(Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                "Looks like you don\'t have any closed tickets!",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ));
        }
      }
    }
    catch (e) {

      if (type == "Open") {
        _openedComplaints.add(Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Looks like you don\'t have any open tickets!",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ));
      }
      else {
        _closedComplaints.add(Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              "Looks like you don\'t have any closed tickets!",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ));
      }
    }
  }
}
