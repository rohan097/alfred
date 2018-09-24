import 'package:flutter/material.dart';

class ShoppingBasket extends StatefulWidget {
  @override
  ShoppingBasketState createState() => new ShoppingBasketState();
}

class MyItem {
  MyItem({ this.isExpanded: false, this.header, this.body });

  bool isExpanded;
  final String header;
  final String body;
}

class ShoppingBasketState extends State<ShoppingBasket> {
  List<MyItem> _items = <MyItem>[
    new MyItem(header: 'header', body: 'body')
  ];

  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: [
        new ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _items[index].isExpanded = !_items[index].isExpanded;
            });
          },
          children: _items.map((MyItem item) {
            return new ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return new Text(item.header);
              },
              isExpanded: item.isExpanded,
              body: new Container(
                child: new Text("body"),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
