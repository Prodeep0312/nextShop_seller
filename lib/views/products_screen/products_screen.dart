import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nextshop_seller/const/const.dart';
import 'package:nextshop_seller/views/products_screen/product_details.dart';
import 'package:nextshop_seller/views/widgets/loading_indicator.dart';

import '../../controllers/products_controller.dart';
import '../../services/store_services.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/text_style.dart';
import 'package:intl/intl.dart' as intl;

import 'add_products.dart';
class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    var controller=Get.put(ProductsController());

    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: ()async{
        await controller.getCategories();
        controller.populateCategoryList();
        Get.to(()=>AddProduct());
      },child: Icon(Icons.add),
      backgroundColor: purpleColor,),
     appBar: appbarWidget(products),
    body: StreamBuilder(
    stream: StoreServices.getProducts(currentUser!.uid),

    
    builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
      if(!snapshot.hasData){
        return loadingIndicator();
    }else
      {var data=snapshot.data!.docs;
        return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
        children: List.generate(data.length, (index) =>ListTile(

        onTap:(){Get.to(()=>ProductDetails(data: data[index],));},
        leading: Image.network(data[index]['p_imgs'][0],width:100,height:100,fit: BoxFit.cover),
        title: boldText(text: "${data[index]['p_name']}",color: fontGrey),
        subtitle: Row(
      children: [
      normalText(text: "\$${data[index]['p_price']}",color: darkGrey),
      10.widthBox,
      boldText(text:data[index]['is_featured']=='true'? "Featured":'',color: green),
      ],
      ),
      trailing:VxPopupMenu(
      arrowSize: 0.0,

      child: Icon(Icons.more_vert_rounded), menuBuilder:()=>Column(
      children: List.generate(popupMenuTitles.length, (i) => Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
      children: [
      Icon(popupMenuIcons[i]),
      10.widthBox,
      normalText(text: popupMenuTitles[i],color: darkGrey),
      ],
      ).onTap(() {
        switch(i)
        {
          case 1:
            break;
          case 2:controller.removeProduct(data[index].id);
          VxToast.show(context, msg: "Product removed");
            break;
          default:
        }

      }),
      ))
      ).box.white.width(200).rounded.make(), clickType: VxClickType.singleClick)
      ))

      ),
      ),
      );
      }
    }

     ),

    );
  }
}
