import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageStat createState() => _MessagePageStat();
}

class _MessagePageStat extends State<MessagePage> {
  String title = "true";
  // final FocusNode myFocusNode = FocusNode();
  final items = List<String>.generate(20, (i) => ' ${i + 1}');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext ctx, index) {
              // Display the list item
              return Dismissible(
                key: UniqueKey(),

                // only allows the user swipe from right to left
                direction: DismissDirection.endToStart,

                // Remove this product from the list
                // In production enviroment, you may want to send some request to delete it on server side
                onDismissed: (_){
                  setState(() {
                    items.removeAt(index);
                  });
                },

                // Display item's title, price...
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(items[index]),
                    ),
                    title: Text( "nouveaux articles disponible"),
                    subtitle:
                    Text("il y a 1h "),
                  ),
                ),

                // This will show up when the user performs dismissal action
                // It is a red background and a trash icon
                background: Container(
                  color: Colors.red,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
        ));
}
}
