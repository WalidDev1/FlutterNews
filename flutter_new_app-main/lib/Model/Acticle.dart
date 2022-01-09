import 'dart:convert';
import 'package:flutter/cupertino.dart';

class Article with ChangeNotifier {
  String source ;
  String title;
  String description ;
  String urlPr ;
  String urlImg ;
  String dateP ;


  Article({this.title , this.description , this.source , this.urlImg , this.urlPr , this.dateP});

  Article postFromJson(String str) {
    final jsonData = json.decode(str);
    // print(jsonData.toString());
    return Article.fromJson(jsonData);
  }

  String postToJson(Article data) {
    final dyn = data.toJson();
    return json.encode(dyn);
  }


  List<Article> allPostsFromJson(String str) {
    final jsonData = json.decode(str);
    // print( jsonData["articles"][0]["urlToImage"]);
    print("response"+jsonData.toString());
    List< Article>  test  ;
    Iterable list = jsonData["articles"] ;
    test = list.map((e) => Article.fromJson(e)).toList();
    // test.forEach((element) {
    //   print(element.dateP);
    // });
    return test;
  }

  String allPostsToJson(List<Article> data) {
    final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
    return json.encode(dyn);
  }

  factory Article.fromJson(Map<String, dynamic> json) => new Article(
    source : json["source"]["name"],
    title: json["title"] ,
    description: json["description"],
    dateP : json["publishedAt"] ,
    urlImg: json["urlToImage"] ,
    urlPr: json["url"] ,
  );

  Map<String, dynamic> toJson() => {
  "source": source,
  "title": title,
  "description": description,
  "dateP": dateP,
    "urlImg": urlImg,
    "urlPr": urlPr,
  };

}

class artc {
  List<Article> art ;
  artc({this.art});
}