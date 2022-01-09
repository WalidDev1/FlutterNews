import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new_app/Model/Acticle.dart';
import '../API/services.dart';
import 'MainRow.dart';
import 'DetailArticle.dart';
import '../Utils/SkeletonLoading.dart';

class CustomCentent extends StatefulWidget {
  const CustomCentent({Key key,@required this.title}) : super(key: key);
  final String title;

  @override
  _CustomCentent createState() => new _CustomCentent();
}

class _CustomCentent extends State<CustomCentent> {
  int present = 0;
  int perPage = 15;
  String  cat  = "";
  List<Article> originalItems = [];
  List<Article> items = [];

  @override
  void initState([String categorie]) {
    super.initState();

    setState(() {
      if (!originalItems.isEmpty){
        items.addAll(originalItems.getRange(present, present + perPage));
        present = present + perPage;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
        height: 300.0,
        child: FutureBuilder<List<Article>>(
            future: getPost(widget.title),
            builder: (context, snapshot) {
                if (snapshot.hasData && originalItems.isEmpty){
                  originalItems = snapshot.data ;
                  items.addAll(originalItems.getRange(present, present + perPage));
                  present = present + perPage;
                }
              return (snapshot.data == null)
                  ? Center(
                      child: SkeletonLoading(),
                    )
                  : ListView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      itemCount: (present <= originalItems.length )
                          ? items.length + 1
                          : items.length,
                      itemBuilder: (context, index) {
                        return (index == items.length)
                            ? Container(
                                color: Colors.white,
                                child: FlatButton(
                                  child: Text("Load More",
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                      )),
                                  onPressed: () {
                                    setState(() {
                                      if ((present + perPage) >
                                          originalItems.length) {
                                        items.addAll(originalItems.getRange(
                                            present, originalItems.length));
                                      } else {
                                        items.addAll(originalItems.getRange(
                                            present, present + perPage));
                                      }
                                      present = present + perPage;
                                    });
                                  },
                                ),
                              )
                            : MainRow(
                                title: "${snapshot.data[index].title}",
                                imageMain: "${snapshot.data[index].urlImg}",
                                publisedAt: "${snapshot.data[index].dateP}",
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute<void>(
                                          builder: (BuildContext context) {
                                    return ActicleDetails(articleS: snapshot.data[index]);
                                  }));
                                },
                              );
                      },
                    );
            })
    );
  }
}
