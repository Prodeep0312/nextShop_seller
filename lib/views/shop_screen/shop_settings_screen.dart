import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:nextshop_seller/const/const.dart';
import 'package:nextshop_seller/views/widgets/loading_indicator.dart';

import '../../controllers/profile_controller.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/text_style.dart';

class ShopSettings extends StatelessWidget {
  const ShopSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller=Get.find<ProfileController>();
    return Obx(()=>
       Scaffold(
          resizeToAvoidBottomInset: false,
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: shopSettings,size: 16.0),
          actions: [
            controller.isloading.value?loadingIndicator(circleColor: white):

            TextButton(onPressed: ()async{
              controller.isloading(true);

              await controller.updateShop(
                shopaddress: controller.shopAddressController.text,
                shopwebsite: controller.shopWebsiteController.text,
                shopmobile: controller.shopMobileController.text,
                shopdesc: controller.shopDescController.text,
                shopname: controller.shopnNmeController.text,




              );
              VxToast.show(context, msg: "Shop Updated!");
            }, child:normalText(text: save,color: white))
          ],


        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              customTextField(label: shopname,hint: nameHint,controller:controller.shopnNmeController ),
              10.heightBox,
              customTextField(label: address,hint: shopAddressHint,controller: controller.shopAddressController),10.heightBox,
              customTextField(label: mobile,hint: shopMobileHint,controller: controller.shopMobileController),10.heightBox,
              customTextField(label: website,hint: shopWebsiteHint,controller: controller.shopWebsiteController),10.heightBox,
              customTextField(label: description,hint: shopDescHint,isDesc: true,controller: controller.shopDescController)


            ],

          ),
        ),

      ),
    );
  }
}
