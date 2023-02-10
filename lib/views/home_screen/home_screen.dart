import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nextshop_seller/const/const.dart';
import 'package:nextshop_seller/views/products_screen/product_details.dart';
import 'package:nextshop_seller/views/widgets/loading_indicator.dart';
import 'package:nextshop_seller/views/widgets/text_style.dart';
import 'package:intl/intl.dart' as intl;

import '../../services/store_services.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/dashboard_button.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: appbarWidget(dashboard),

      body: StreamBuilder(
        stream: StoreServices.getProducts(currentUser!.uid),


          builder:(BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){

          if(!snapshot.hasData){

            return loadingIndicator();
          }else{
            var data=snapshot.data!.docs;
            data=data.sortedBy((a, b) => b['p_wishlist'].length.compareTo(a['p_wishlist'].length));


            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DashBoardButton(context,title: products,count:"${data.length}",icon: icProducts),
                      DashBoardButton(context,title: orders,count:"40",icon: icOrders),
                    ],
                  ),
                  10.heightBox,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DashBoardButton(context,title: rating,count:"4",icon: icStars),
                      DashBoardButton(context,title: totalSales,count:"23",icon: icOrders),
                    ],
                  ),
                  10.heightBox,
                  Divider(),
                  10.heightBox,
                  boldText(text: popular,size: 16.0,color: fontGrey),
                  20.heightBox,
                  ListView(
                      physics: BouncingScrollPhysics(),

                      shrinkWrap: true,
                      children:
                      List.generate(data.length, (index) => data[index]['p_wishlist'].length==0?SizedBox():ListTile(
                        onTap:(){
                          Get.to(()=>ProductDetails(data: data[index],));
                        },
                        leading: Image.network(data[index]['p_imgs'][0],width:100,height:100,fit: BoxFit.cover),
                        title: boldText(text: "${data[index]['p_name']}",color: fontGrey),
                        subtitle: normalText(text: "\$${data[index]['p_price']}",color: darkGrey),

                      ))

                  )











                ],
              ),
            );
          }

          }),


    );
  }
}
