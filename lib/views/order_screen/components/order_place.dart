import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nextshop_seller/const/const.dart';

import '../../widgets/text_style.dart';



Widget orderPlaceDetails({title1,title2,d1,d2}){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            boldText(text: "$title1",color: purpleColor),
            boldText(text: "$d1",color: red),


          ],
        ),
        SizedBox(
          width: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              boldText(text: "$title2",color: purpleColor),
              boldText(text: "$d2",color: fontGrey),
            ],
          ),
        ),
      ],
    ),
  );
}




