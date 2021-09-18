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


class CategoryScreen extends StatefulWidget {
  String Category;

  CategoryScreen(this.Category);


  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  Api api= Api();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackGround,
      body: Column(
        children: [
          //TitleText
          //ListCategories
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 20,right: 20,top: 30,bottom: 10),
            child: Text(
              "${widget.Category} Category News",
              style: TextStyle(color: textColor, fontSize: fontlarge),
            ),
          ),
          Expanded(
              child: Container(
                  padding: EdgeInsets.all(10),
                  child: FutureBuilder(
                    
                    future: api.ListArticlesCategory(widget.Category),
                    
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

                      if(snapshot.hasData){
                        return ListView.builder(
                            itemCount: snapshot.data.length,


                            itemBuilder: (context,i){
                              return GestureDetector(
                                  onTap: ()
                                  {
                                    fun.openurl("${snapshot.data[i].url}");

                                  },
                                  child: Card(
                                    color: Colors.grey,
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
                                                      "{${snapshot.data[i].title}",
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
                                                    padding: EdgeInsets.symmetric(vertical: 30),
                                                    child: IconButton(onPressed: (){
                                                      fun.sharelink('${snapshot.data[i].url}');
                                                    }, icon: Icon(Icons.share)),
                                                  ),
                                                  Container(
                                                    color: green,
                                                    padding: EdgeInsets.symmetric(vertical: 30),
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

                      }else{
                        return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.yellow,
                            ),
                        );
                      }

                    },


                  )
              )
          )
        ],
      ),



    );
  }
}

