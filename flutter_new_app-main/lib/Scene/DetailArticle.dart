import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new_app/Model/Acticle.dart';

import 'MainRow.dart';

class ActicleDetails extends StatefulWidget {
  final Article articleS ;
  const ActicleDetails({ Key key , this.articleS }) : super(key: key);

  @override
  _ActicleDetailsState createState() => _ActicleDetailsState();
}

class _ActicleDetailsState extends State<ActicleDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Set background to blue to emphasize that it's a new route.
        alignment: Alignment.topLeft,
        child:
        MainRow(
            title:
            "${widget.articleS.title}",
            imageMain:
            "${widget.articleS.urlImg}",
            publisedAt:"${widget.articleS.dateP}" ,
            onTap: () {

            },
            forDetail: true,
            article:widget.articleS ,
        ),
      ),
    );
  }
}