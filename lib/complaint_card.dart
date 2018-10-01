import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:alfred/globals.dart' as globals;

typedef VoidNavigate = void Function(Map<String, dynamic>);

class ComplaintCard extends StatefulWidget {
  final VoidNavigate onChoosingTime;
  final String type;
  final String complaintId;
  final String productType;
  final String issueType;
  final String description;
  final String date;
  final String progress;
  final String status;
  final List<Map<String, dynamic>> timeSlots;
  String timeSlot;
  List<bool> timeSlotChosen = [false, false, false, false];
  Map<dynamic, dynamic> callDetails;

  ComplaintCard({
    this.type,
    this.complaintId,
    this.productType,
    this.issueType,
    this.description,
    this.date,
    this.progress,
    this.timeSlot,
    this.status,
    this.callDetails = const {"Date": "0", "Time": "0,"},
    this.timeSlots = const [
      {"Date": "0", "Time": "0"},
      {"Date": "0", "Time": "0"},
      {"Date": "0", "Time": "0"}
    ],
    this.onChoosingTime,
  });

  @override
  ComplaintCardState createState() => ComplaintCardState();
}

class ComplaintCardState extends State<ComplaintCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.blueGrey[50],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            titleBar(),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Ticket ID: ${widget.complaintId}",
                style: TextStyle(fontSize: 16.0),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Issue: ${widget.issueType}",
                style: TextStyle(fontSize: 16.0),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                widget.type == "House Call"?
                "Description: ${widget.description}": "Time of Call: ${widget.callDetails["Time"] == "0"?"Not yet confirmed": widget.callDetails["Time"]}",
                style: TextStyle(fontSize: 16.0),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Date Created: ${widget.date}",
                style: TextStyle(fontSize: 16.0),
                textAlign: TextAlign.left,
              ),
            ),
            Divider(
              height: 8.0,
            ),
            timeOptions(widget.timeSlots),
          ],
        ),
      ),
    );
  }

  Container titleBar() {
    Color issueColor = Colors.blueGrey[100];
    print(widget.progress);
    if (widget.progress.toLowerCase() == "under review.") {
      issueColor = Color.fromRGBO(255, 255, 255, 1.0);
    } else if (widget.progress.toLowerCase() == "agent allotted." || widget.progress.toLowerCase() == "call scheduled") {
      issueColor = Color(0xFFE6BB24);
    } else if (widget.progress.toLowerCase() == "resolved.") {
      issueColor = Colors.lightGreen;
    }

    return Container(
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        color: Color(0xFFC54B25),
      ),
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Icon(widget.type == "House Call"? Icons.home: Icons.phone),
          Text("${widget.productType}",
              style: TextStyle(fontSize: 24.0, color: Colors.white)),
          DecoratedBox(
            decoration: new BoxDecoration(
              color: issueColor,
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(
                width: 1.5,
                color: issueColor,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("${widget.progress}", style: TextStyle()),
            ),
          ),
        ],
      ),
    );
  }

  Widget timeOptions(List<Map<String, dynamic>> time) {

    if (widget.type == "House Call" && widget.status == "Open") {
      if (widget.timeSlot == "1") {
        widget.timeSlotChosen[0] = true;
        widget.timeSlotChosen[1] = false;
        widget.timeSlotChosen[2] = false;
        widget.timeSlotChosen[3] = false;
      } else if (widget.timeSlot == "2") {
        widget.timeSlotChosen[0] = false;
        widget.timeSlotChosen[1] = true;
        widget.timeSlotChosen[2] = false;
        widget.timeSlotChosen[3] = false;
      } else if (widget.timeSlot == "3") {
        widget.timeSlotChosen[0] = false;
        widget.timeSlotChosen[1] = false;
        widget.timeSlotChosen[2] = true;
        widget.timeSlotChosen[3] = false;
      } else if (widget.timeSlot == "4") {
        widget.timeSlotChosen[0] = false;
        widget.timeSlotChosen[1] = false;
        widget.timeSlotChosen[2] = false;
        widget.timeSlotChosen[3] = true;
      }
      print(widget.timeSlotChosen);
      print("Going to render now");
      if (time[0]["Time"] == "0") {
        return Center(
          child: Text(
            "No time slots have been alotted yet.",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        );
      } else {
        return Column(
          children: <Widget>[
            Text(
              "Available slots for visit",
              style: TextStyle(
                fontSize: 16.0,
                decoration: TextDecoration.underline,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    child: Text(
                        "Date: ${time[0]["Date"]}\nTime: ${time[0]["Time"]}"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: widget.timeSlotChosen[0]
                        ? Colors.deepOrangeAccent
                        : Colors.grey,
                    onPressed: () {
                      widget.timeSlotChosen[0] = true;
                      widget.timeSlotChosen[1] = false;
                      widget.timeSlotChosen[2] = false;
                      widget.timeSlotChosen[3] = false;
                      _chosenTime();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    child: Text(
                        "Date: ${time[1]["Date"]}\nTime: ${time[1]["Time"]}"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: widget.timeSlotChosen[1]
                        ? Colors.deepOrangeAccent
                        : Colors.grey,
                    onPressed: () {
                      widget.timeSlotChosen[0] = false;
                      widget.timeSlotChosen[1] = true;
                      widget.timeSlotChosen[2] = false;
                      widget.timeSlotChosen[3] = false;
                      _chosenTime();
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    child: Text(
                        "Date: ${time[2]["Date"]}\nTime: ${time[2]["Time"]}"),
                    color: widget.timeSlotChosen[2]
                        ? Colors.deepOrangeAccent
                        : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    onPressed: () {
                      widget.timeSlotChosen[0] = false;
                      widget.timeSlotChosen[1] = false;
                      widget.timeSlotChosen[2] = true;
                      widget.timeSlotChosen[3] = false;
                      _chosenTime();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    child: Text("Request another\n slot."),
                    color: widget.timeSlotChosen[3]
                        ? Colors.deepOrangeAccent
                        : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    onPressed: () {
                      widget.timeSlotChosen[0] = false;
                      widget.timeSlotChosen[1] = false;
                      widget.timeSlotChosen[2] = false;
                      widget.timeSlotChosen[3] = true;
                      _chosenTime();
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      }
    }
    else {
      return Container();
    }
  }

  void _chosenTime() {
    String time;
    if (widget.timeSlotChosen[0]) {
      time = "1";
      widget.timeSlot = "1";
    } else if (widget.timeSlotChosen[1]) {
      time = "2";
      widget.timeSlot = "2";
    } else if (widget.timeSlotChosen[2]) {
      time = "3";
      widget.timeSlot = "3";
    } else if (widget.timeSlotChosen[3]) {
      time = "Request another";
      widget.timeSlot = "0";
    }
    setState(() {});
    uploadTime(time);
  }

  void uploadTime(String time) async {
    var url = "http://159.89.175.161:3000/choosetimeslot/";
    print("Intime");
    print(time);
    var body = {
      "firebase_uid": globals.firebaseUID,
      "complaint_id": widget.complaintId,
      "time_slot": time
    };
    print(body);
    var response = await http.post(url,
        headers: {"Content-type": "application/json"},
        body: utf8.encode(json.encode(body)));

    if (response.statusCode == 200) {
      final snackBar = SnackBar(
        content: Text("Your preferred time slot has been noted."),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    } else if (response.statusCode != 200) {
      final snackBar = SnackBar(
        content: Text("Something went wrong. Please try again later."),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
    print(widget.timeSlotChosen);
  }
}
