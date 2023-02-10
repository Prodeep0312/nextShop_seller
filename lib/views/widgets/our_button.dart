import 'package:flutter/material.dart';
import 'package:nextshop_seller/const/const.dart';
import 'package:nextshop_seller/views/widgets/text_style.dart';

Widget ourButton({title,color=purpleColor,onPress}){
  return ElevatedButton(

    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),

      primary: color,
      padding: EdgeInsets.all(12),
    ),


      onPressed:onPress, child:boldText(text: title,size: 16.0));
}