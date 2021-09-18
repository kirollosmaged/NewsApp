import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:newapp/ScreenView/CategoryScreen.dart';

class CategoriesButtons extends StatelessWidget {
  String? TextCategories;
  String? Categories;
  Color? colorButton;

  CategoriesButtons({this.TextCategories, this.Categories, this.colorButton});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: RaisedButton(

          onPressed: (){

            Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryScreen(("$Categories"))));

            print("$Categories");
          },
        child: Text(
          "$TextCategories",
          style: TextStyle(color: Colors.white),
        ),
        color: colorButton,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        )

      ),
    );
  }
}
