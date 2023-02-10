import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nextshop_seller/const/const.dart';
import 'package:intl/intl.dart'as intl;

import '../../controllers/orders_controller.dart';
import '../../services/store_services.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/text_style.dart';
import 'orders_details.dart';
class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(OrdersController());

  return Scaffold(
    appBar: appbarWidget(orders),

      body:StreamBuilder(
          stream: StoreServices.getOrders(currentUser!.uid),

          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
            if(!snapshot.hasData){
              return loadingIndicator(circleColor: white);
            }else
            {var data=snapshot.data!.docs;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(

                    children:List.generate(data.length, (index) {

                      var time=data[index]['order_date'].toDate();
                      return ListTile(



                        onTap:(){
                          Get.to(()=>OrderDetails(data: data[index]));
                        },
                        tileColor: textfieldGrey,
                        title: boldText(text: "${data[index]['order_code']}",color:purpleColor),
                        subtitle: Column(
                          children: [
                            Row(children: [
                              Icon(Icons.calendar_month,color: fontGrey,),
                              10.widthBox,
                              boldText(text: intl.DateFormat().add_yMd().format(time),color: fontGrey)
                            ],),

                            Row(children: [
                              Icon(Icons.payment,color: fontGrey,),
                              10.widthBox,
                              boldText(text:unpaid,color: red),

                            ],)
                            //normalText(text: "\$40",color: darkGrey),

                          ],

                        ),
                        trailing: boldText(text: "\$ ${data[index]['total_amount']}",color:purpleColor,size: 16.0 ),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ).box.margin(EdgeInsets.only(bottom: 4)).make();
                    }
                    ),
                  ),
                ),
              );
            }

          })
   );
  }
}
