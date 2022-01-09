import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new_app/API/services.dart';
import 'package:flutter_new_app/Model/Acticle.dart';
import 'package:flutter_new_app/Utils/SkeletonLoading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'MainRow.dart';
import 'DetailArticle.dart';

class SeachView extends StatefulWidget {
  const SeachView({ Key key  }) : super(key: key);

  @override
  _SeachViewState createState() => _SeachViewState();
}
class _SeachViewState extends State<SeachView> {
  int present = 0;
  int perPage = 15;
  String  cat  = "";
  List<Article> originalItems = [];
  List<Article> items = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 60,
            margin: EdgeInsets.only(left: 20,right: 20 , top: 10 , bottom: 10 ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.black12,
            ),
            child: Row(
              children: [
                InkWell(
                  child: IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 30.0,),
                    onPressed:() {
                      setState(() {
                        // Navigator.of(cnt).pop();
                        // widget.isSearching = true;
                      });
                    },
                  ),
                ),
                Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: null,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Chercher',
                      ),
                      onChanged: (text) {
                        setState(() {
                          // widget.isSearching = (text != "") ? true : false;
                        });
                        print('First text field: $text');
                        cat = text ;
                      },
                    )
                ),
                IconButton(
                    icon: const Icon(
                      Icons.filter_alt_rounded,
                      color: Colors.grey,
                      size: 30.0,)
                ),
              ],
            ),
          ),
          (cat == "") ? Center(
            child:
            Column(
              children: <Widget>[
                Lottie.network('https://assets6.lottiefiles.com/packages/lf20_83ssyqhj.json'),
                Text("Commencer votre recherche",
                  style: GoogleFonts.ubuntu(color: Colors.grey , fontWeight: FontWeight.w500 , fontSize: 20),
                )
              ],
          ),

          ) : Expanded(

              child: FutureBuilder<List<Article>>(
                  future: getPostSeach(cat),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && originalItems.isEmpty){
                      originalItems = snapshot.data ;
                      items.addAll(originalItems.getRange(present, present + perPage));
                      present = present + perPage;
                    }
                    //
                    return (snapshot.data == null)
                        ? Center(child: SkeletonLoading()) : (snapshot.data.length == 0)
                        ?  Column(
                      children: <Widget>[
                        Lottie.network('https://assets1.lottiefiles.com/packages/lf20_ndk1Mk.json'),
                        Text("Aucun article trouver !",
                          style: GoogleFonts.ubuntu(color: Colors.grey , fontWeight: FontWeight.w500 , fontSize: 20),
                        )
                      ],
                    ) :
                    ListView.builder(
                      padding: EdgeInsets.only(left: 15 , right: 15),
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
          )
        ],
      ),
    );
  }
}