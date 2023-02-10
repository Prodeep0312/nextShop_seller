import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:nextshop_seller/const/const.dart';
import 'package:flutter/material.dart';
import 'package:nextshop_seller/views/widgets/text_style.dart';

import '../../../controllers/products_controller.dart';

Widget productDropDown(hint,List<String>list,dropvalue,ProductsController controller){

  return DropdownButtonHideUnderline(

      child: Obx(()=>
         DropdownButton(
          hint: normalText(text: "$hint",color: fontGrey),
          value: dropvalue.value==''?null:dropvalue.value,
            isExpanded: true,
            items:list.map((e){
              return DropdownMenuItem(child:e.toString().text.make(),
              value: e,);

            }).toList(),
            onChanged: (newValue){
            if(hint=="Category"){
              controller.subcategoryvalue.value='';
              controller.populateSubcategoryList(newValue.toString());
            }
            dropvalue.value=newValue.toString();


            },),
      )).box.white.padding(EdgeInsets.symmetric(horizontal: 4)).roundedSM.make();
}