import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newapp/Service/Api.dart';
import 'package:newapp/Service/Fun.dart';
import 'package:newapp/widgets/CategoriesButtons.dart';
import 'package:share/share.dart';
import 'package:clipboard/clipboard.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constant.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Future<void>_openurl(String link)
  async {
    var url=link;
    if(await canLaunch(url))
      {
        await launch(url);
      }
    else
      {
        await launch(url);
      }
  }

  Api api=Api();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackGround,
      body: Column(
        children: [
        //TitleText
          Container(
            padding: EdgeInsets.only(left: 20,right: 20,top: 30),
            child: Text(
              "Choose a category",
              style: TextStyle(color: textColor, fontSize: fontbigger),
            ),
          ),
        //ListCategories
          Container(
            height: 60,
            padding: EdgeInsets.all(5),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                  CategoriesButtons(TextCategories: "General", colorButton: blue, Categories: "general"),
                  CategoriesButtons(TextCategories: "Science", colorButton: yellow, Categories: "science"),
                  CategoriesButtons(TextCategories: "Health", colorButton: red, Categories: "health"),
                  CategoriesButtons(TextCategories: "Business", colorButton: green, Categories: "business"),
                  CategoriesButtons(TextCategories: "Sports", colorButton: orangedark, Categories: "sports"),
                  CategoriesButtons(TextCategories: "Entertainment", colorButton: blue, Categories: "entertainment"),
                  CategoriesButtons(TextCategories: "Technology", colorButton: orangelight, Categories: "technology"),

              ],
            )


          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 20,right: 20,top: 30,bottom: 10),
            child: Text(
              "Featured",
              style: TextStyle(color: textColor, fontSize: fontlarge),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: FutureBuilder(

                future: api.ListArticles(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if(snapshot.data==null){
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.yellow,
                      ),
                    );
                  }else{
                    return ListView.builder(
                        itemCount: snapshot.data.length,

                        itemBuilder: (context,i){
                          return GestureDetector(
                              onTap: ()
                              {
                                fun.openurl("${snapshot.data[i].url}");

                              },
                              child: Card(
                                color: Colors.white,
                                child: Container(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 80,
                                          child: Container(
                                            color: Colors.white,
                                            child: Column(
                                              children: [
                                                Padding(
                                                    padding: const EdgeInsets.all(8),
                                                    child: Image.network(
                                                      (snapshot.data[i].urlToImage==null)?"https://blog.sinapsis.agency/wp-content/uploads/2021/04/DEFINICIONES.-ERROR-404.png":snapshot.data[i].urlToImage,
                                            fit: BoxFit.fitWidth,)
                                                ),
                                                Text(
                                                  "${snapshot.data[i].title}",
                                                  style: TextStyle(fontSize: fontSubTitle,fontWeight: FontWeight.w800),
                                                  textAlign: TextAlign.center,
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                color: orangelight,
                                                padding: EdgeInsets.symmetric(vertical: 40),
                                                child: IconButton(onPressed: (){
                                                  fun.sharelink('${snapshot.data[i].url}');
                                                }, icon: Icon(Icons.share)),
                                              ),
                                              Container(
                                                color: green,
                                                padding: EdgeInsets.symmetric(vertical: 40),
                                                child: IconButton(onPressed: (){
                                                  fun.copylink('${snapshot.data[i].url}');
                                                  final snackBar = SnackBar(content: Text('Link Copied!'));
                                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                }, icon: Icon(Icons.copy)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                              )
                          );
                    });
                  }
                },





              ),
            ),
          ),
        ],
      ),



    );
  }
}
