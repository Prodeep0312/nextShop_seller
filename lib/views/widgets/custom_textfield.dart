import 'package:flutter/material.dart';
import 'package:nextshop_seller/const/const.dart';
import 'package:nextshop_seller/views/widgets/text_style.dart';

Widget customTextField({label,hint,controller,isDesc=false}){
  return TextFormField(
    style: TextStyle(color: Colors.white),
    controller: controller,
    maxLines: isDesc?4:1,
    decoration: InputDecoration(
      isDense: true,
      label: normalText(text: label),
      /*enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.white,
          )
      ),*/
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: Colors.white,
        )
      ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.white,
            )
        ),
      hintText: hint,
      hintStyle: TextStyle(
        color: lightGrey
      ),
    ),
  );
}