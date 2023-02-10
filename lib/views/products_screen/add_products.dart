import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextshop_seller/const/const.dart';
import 'package:nextshop_seller/controllers/profile_controller.dart';
import 'package:nextshop_seller/views/products_screen/components/product_images.dart';
import 'package:nextshop_seller/views/widgets/custom_textfield.dart';
import 'package:nextshop_seller/views/widgets/loading_indicator.dart';

import '../../controllers/products_controller.dart';
import '../widgets/text_style.dart';
import 'components/product_dropdown.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller=Get.find<ProductsController>();//see here once==========

    return Obx(()=>
      Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: "Add product",color: white,size: 16.0),
          leading: IconButton(onPressed: (){
            Get.back();
          },
            icon: Icon(Icons.arrow_back,color: white),),
          actions: [
            controller.isloading.value?loadingIndicator(circleColor: white):TextButton(onPressed: ()async{
              controller.isloading(true);
              await controller.uploadImages();
              await controller.uploadProduct(context);
              Get.back();



            }, child: boldText(text: save,color: white))
          ],


        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextField(hint: "eg. BMW", label: "Product name",controller: controller.pnameController),
                10.heightBox,
                customTextField(hint: "eg. Nice Product", label: "Description",isDesc:true,controller: controller.pdescController),
                10.heightBox,
                customTextField(hint: "eg. \$100", label: "Price",controller: controller.ppriceController),
                10.heightBox,
                customTextField(hint: "eg. 20", label: "Quantity",controller: controller.pquantityController),
                10.heightBox,
                productDropDown("Category",controller.categoryList.value,controller.categoryvalue,controller),
                10.heightBox,
                productDropDown("Subcategory",controller.subcategoryList.value,controller.subcategoryvalue,controller),
                10.heightBox,
                Divider(color: white,),
                boldText(text: "Choose product images"),
                10.heightBox,
                Obx(()=>
                 Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:
                      List.generate(3, (index) => controller.pImagesList[index]!=null?Image.file(controller.pImagesList[index],width: 100,).onTap(() {
                        controller.pickImage(index, context);
                      }):productImages(label: "${index+1}").onTap(() {
                        controller.pickImage(index, context);
                      }))
                    ,
                  ),
                ),
                5.heightBox,
                normalText(text: "First image will be your display image",color: lightGrey),
                Divider(color: white,),
                10.heightBox,
                boldText(text: "Choose product colors"),
                10.heightBox,
                Obx
                  (()=>
                   Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children:
                      List.generate(9, (index) =>

                          Stack(
                            alignment: Alignment.center,
                            children: [
                              VxBox().color(Vx.randomPrimaryColor).roundedFull.size(50, 50).make().onTap(() {

                                controller.selectedColorIndex.value=index;
                              }),
                              controller.selectedColorIndex.value==index?
                              Icon(Icons.done,color: white,):SizedBox(),
                            ],
                          ),

                  ),),
                )


              ],
            ),
          ),
        ),

      ),
    );
  }
}
