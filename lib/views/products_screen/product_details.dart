import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextshop_seller/const/const.dart';

import '../widgets/text_style.dart';


class ProductDetails extends StatelessWidget {
  final dynamic data;
  const ProductDetails({Key? key,this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       leading: IconButton(onPressed: (){
         Get.back();
       },
       icon: Icon(Icons.arrow_back,color: darkGrey,),),
       title: boldText(text:"${data['p_name']}",color: fontGrey,size: 16.0),
     ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VxSwiper.builder(
                autoPlay: true,
                height: 350.0,
                aspectRatio: 16/9,
                viewportFraction: 1.0,//1 img in 1 screen at a time
                itemCount: data['p_imgs'].length, itemBuilder:(context,index){
              return Image.network(data['p_imgs'][index]
                   ,width: double.infinity,fit: BoxFit.cover,);
            }),

            10.heightBox,
            //titles and details section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  boldText(text:"${data['p_name']}",color: fontGrey,size: 16.0),
                  //title!.text.size(16).color(darkFontGrey).fontFamily(semibold).make(),
                  10.heightBox,
                  Row(children: [
                    boldText(text: "${data['p_category']}",color: fontGrey,size: 16.0),
                    10.widthBox,
                    normalText(text: "${data['p_subcategory']}",color: fontGrey,size: 16.0),
                  ],),
                  10.heightBox,
                  //rating
                  VxRating(onRatingUpdate: (value){

                  },
                    value: double.parse(data['p_rating']),

                    normalColor: textfieldGrey,
                    isSelectable: false,//user cannot manually change rating
                    selectionColor:Vx.yellow400,
                    count:5,
                    maxRating: 5,
                    size:25,
                  ),
                  10.heightBox,
                  boldText(text: "\$${data['p_price']}",color: red,size: 18.0),

                  10.heightBox,

                      Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100.0,
                                child: boldText(text: "Color",color: fontGrey),
                                //child: "Color".text.color(textfieldGrey).make(),
                              ),
                              Row(
                                children: List.generate(data['p_colors'].length, (index) =>

                                    VxBox().size(40,40).color(Color(data['p_colors'][index])).margin(EdgeInsets.symmetric(horizontal: 4)).roundedFull.make().onTap(() {

                                    })),
                              ),

                            ],
                          ),
                          10.heightBox,

                          //quantity section

                          Row(
                            children: [
                              SizedBox(
                                width: 100.0,
                                child: boldText(text: "Quantity",color: fontGrey),
                              ),
                              normalText(text: "${data['p_quantity']}",color: fontGrey,)





                            ],
                          ),

                        ],
                      ).box.white.padding(EdgeInsets.all(8)).make(),
                  Divider(),
                  20.heightBox,
                  //description section
                  boldText(text: "Description",color: fontGrey),

                  10.heightBox,
                  normalText(text: "${data['p_desc']}",color: fontGrey,)








                ],

              ),
            )



          ],
        ),
      ),
    );
  }
}
