import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new_app/Model/Acticle.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../Utils/Extension.dart';

class MainRow extends StatelessWidget {
  MainRow({@required this.title, @required this.imageMain , @required this.publisedAt , this.onTap ,this.forDetail , this.article});
  final Article article ;
  final String title;
  final String imageMain;
  final String publisedAt;
  final VoidCallback onTap;
  bool forDetail = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height:(forDetail == true) ? MediaQuery.of(context).size.height :  100,
        margin:(forDetail == true) ? EdgeInsets.only(top: 0): EdgeInsets.only(top: 30),
        child: Hero(
          tag: imageMain,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: (forDetail == true) ?  articleDetail(article , context) :  Row(
                children: [
                  Container(
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                          image: (imageMain == "null")? AssetImage('assets/no_data_found.png') : NetworkImage(imageMain),
                          // errorWidget: (context, url, error) => AssetImage('graphics/background.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsets.only(left: 20),//This helps the text widget know what the maximum width is again! You may also opt to use an Expanded widget instead of a Container widget, if you want to use all remaining space.
                      child: Column(

                        children: [
                          Center( //I added this widget to show that the width limiting widget doesn't need to be a direct parent.
                            child: Text(
                                title,
                                style: GoogleFonts.lato(fontWeight: FontWeight.bold , fontSize: 15),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Icon(Icons.access_time,size: 20,color: Colors.grey,),
                              Text("  ${daysBetween(DateTime.parse(publisedAt)  , DateTime.now())}",style : TextStyle(fontWeight :FontWeight.w600 , color: Colors.grey)),
                              Spacer(),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }

  articleDetail([Article article , BuildContext cnt] ){
    return   SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(cnt).size.height * 0.5,
            child: FittedBox(
              child: Image(
                  image: NetworkImage(article.urlImg),
              ),
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
              child:  Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.of(cnt).pop();
                          },
                        ),
                      ),
                  ]
                  ),
                    // Expanded(child: null),
                  Container(
                    height: MediaQuery.of(cnt).size.height * 0.3 ,
                  ),
                  Container(
                      height: MediaQuery.of(cnt).size.height * 0.55 ,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0) , topRight: Radius.circular(30.0)),

                      ),

                      padding: EdgeInsets.only(top: 30),
                      child:  WebView(
                        initialUrl: '${article.urlPr}',
                      ),
                      // Text(article.description),
                    )

                  ]
              )
          )
        ],
      ),
    );
  }

}
