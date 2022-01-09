import 'package:flutter_new_app/Model/Acticle.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

String url = 'https://newsapi.org/v2/top-headlines?country=ma&language=fr';
String token = "cb3df166d578403cb062d102ac3ca73d";
Future<List<Article>> getPost(String cat) async{
  if (cat == "Covid-19"){
    url = "https://newsapi.org/v2/everything?q=covid-19&language=fr";
  }else{
    url = "https://newsapi.org/v2/top-headlines?country=ma&category=${(cat == "") ? "all" :cat}&language=fr";
  }

  final response = await http.get(url,
      headers: {"Authorization": "Bearer ${token}"});
  return (response.body == null ) ? null : new Article().allPostsFromJson(response.body);
}

Future<List<Article>> getPostSeach(String key) async{
    url = "https://newsapi.org/v2/everything?q=${key}&language=fr";
    final response = await http.get(url,
        headers: {"Authorization": "Bearer ${token}"});
    return (response.body == null ) ? null : new Article().allPostsFromJson(response.body);
}