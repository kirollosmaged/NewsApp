import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:newapp/model/Article.dart';

class Api{
  final String Key='68a8a4bdbec4431dae46302614225dc5';

  Future<List<Article>> ListArticles() async {
    var url = Uri.parse('https://newsapi.org/v2/top-headlines?country=eg&apiKey=$Key');
    List <Article>listArticle=[];

  var response=await http.get(url);
  if(response.statusCode==200)
    {
      var responsebody = jsonDecode(response.body)["articles"];
      print(responsebody);
      for(var x in responsebody){
        Article a=Article(x["title"], x["description"], x["url"], x["urlToImage"]);
        listArticle.add(a);
      }
      print("listadd------>$listArticle");
      return listArticle;
    }
  return listArticle;
  }
  Future<List<Article>> ListArticlesCategory(String Category) async {
    var url = Uri.parse('https://newsapi.org/v2/top-headlines?country=eg&category=$Category&apiKey=$Key');
    List <Article>listArticle=[];

    var response=await http.get(url);
    if(response.statusCode==200)
    {
      var responsebody = jsonDecode(response.body)["articles"];
      print(responsebody);
      for(var x in responsebody){
        Article a=Article(x["title"], x["description"], x["url"], x["urlToImage"]);
        listArticle.add(a);
      }
      print("listadd------>$listArticle");
      return listArticle;
    }
    return listArticle;
  }
}