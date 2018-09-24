import 'package:flutter/material.dart';
import 'package:alfred/firebase_db.dart';
import 'dart:async';
import 'package:alfred/globals.dart' as globals;

final scaffoldKey = GlobalKey<ScaffoldState>();

class SettingScreen extends StatefulWidget {
  SettingScreenState createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen> {
  List<MyPanel> _items = <MyPanel>[
    MyPanel(
        headerText1: "Phone Number",
        headerText2: globals.mobileNumber == "0"? " ": "${globals.mobileNumber}",
        purpose: "updatePhone"),
    MyPanel(
        headerText1: "Address",
        headerText2: globals.address["City"] == "0"?
            " ":
            "${globals.address["Address Line 1"]+", "+globals.address["Address Line 2"]+", "+globals.address["City"]+", "+globals.address["Pincode"]}",
        purpose: "updateAddress"),
  ];

  @override
  Widget build(BuildContext context) {
    print("Building Widget.");
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.blueGrey[200],
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Text("Edit my data",
              style: TextStyle(
                fontSize: 32.0
              ),),
              flex: 1,
            ),
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
              flex: 5,
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
  String purpose;
  String _addressLine1;
  String _addressLine2;
  String _city;
  String _pinCode;
  String _mobileNumber;

  final formKey = GlobalKey<FormState>();

  String headerText1; // Label
  String headerText2; // Value

  Widget panelHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
              child: Text(
                "$headerText1",
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              flex: 1),
          Expanded(
              child: Align(
                child: Text(
                  "$headerText2",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blueGrey[400],
                  ),
                ),
                alignment: Alignment.center,
              ),
              flex: 1),
        ],
      ),
    );
  }

  Widget panelBody() {
    return Padding(
      padding: EdgeInsets.all(32.0),
      child: Column(
        children: <Widget>[
          Form(key: this.formKey, child: buildInputs()),
          Align(
            alignment: Alignment.centerRight,
            child: RaisedButton(
              child: Text("Submit"),
              elevation: 5.0,
              onPressed: updateData,
            ),
          )
        ],
      ),
    );
  }

  Column buildInputs() {
    if (purpose == "updateAddress") {
      return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          /*For address line */
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Address Line 1",
              ),
              validator: (value) => value.isEmpty ? "Cannot be empty" : null,
              onSaved: (value) => _addressLine1 = value,
            ),
          ),
          /* End of for address line 1*/

          /* Begin of for address line 2*/
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Address Line 2",
              ),
              validator: (value) => value.isEmpty ? "Cannot be empty" : null,
              onSaved: (value) => _addressLine2 = value,
            ),
          ),
          /* End of for address line 2*/

          /* Begin of for address row - City and pincode*/
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "City",
                    ),
                    validator: (value) =>
                        value.isEmpty ? "Cannot be empty" : null,
                    onSaved: (value) => _city = value,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Pincode",
                    ),
                    validator: (value) =>
                        value.isEmpty ? "Cannot be empty" : null,
                    onSaved: (value) => _pinCode = value,
                  ),
                ),
              ),
            ],
          ),
          /* End of for address row - City and pincode*/
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Enter new phone number.",
              ),
              validator: (value) => value.isEmpty ? "Cannot be empty" : null,
              onSaved: (value) => _mobileNumber = value,
            ),
          ),
        ],
      );
    }
  }

  MyPanel(
      {this.isExpanded: false,
      this.headerText1,
      this.headerText2,
      this.purpose});

  void updateData() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();


      BaseDB db = new DB();
      if (this.purpose == "updatePhone") {
        db.updateUserMobile(_mobileNumber);
      } else {
        Map<dynamic, dynamic> data;
        data = {
          "Address Line 1": _addressLine1,
          "Address Line 2": _addressLine2,
          "City": _city,
          "Pincode": _pinCode,
        };
        db.updateUserAddress(data);
      }
      print (globals.firebaseUID);
      globals.updateGlobalDataFromInternet(globals.firebaseUID);

      SnackBar snackBar = SnackBar(
          content: Text("Sucessfully updated ${this.purpose.toLowerCase()}."));

      scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }
}
