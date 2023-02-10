import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nextshop_seller/const/const.dart';
import 'package:nextshop_seller/controllers/auth_controller.dart';
import 'package:nextshop_seller/views/auth_screen/login_screen.dart';

import '../../controllers/profile_controller.dart';
import '../../services/store_services.dart';
import '../messages_screen/messages_screen.dart';
import '../shop_screen/shop_settings_screen.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/text_style.dart';
import 'edit_profile_screen.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(ProfileController());
      return Scaffold(
        backgroundColor: purpleColor,

        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: boldText(text: settings,size: 16.0),
          actions: [
            IconButton(onPressed: (){
              Get.to(()=>EditProfileScreen(

                username: controller.snapshotData['vendor_name'],
              ));
            }, icon:Icon(Icons.edit)),
            TextButton(onPressed: ()async{


              await Get.find<AuthController>().signoutMethod(context);
              Get.offAll(()=>LoginScreen());
            }, child:normalText(text: logout))
          ],

        ),
        body:FutureBuilder(
          future: StoreServices.getProfile(currentUser!.uid),

            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
            if(!snapshot.hasData){
              return loadingIndicator(circleColor: white);
            }else
              {controller.snapshotData=snapshot.data!.docs[0];

                return  Column(
                  children: [
                    ListTile(
                     // leading: Image.asset(imgProduct).box.roundedFull.clip(Clip.antiAlias).make(),

                      leading:controller.snapshotData['imageUrl']==''?
                      Image.asset(imgProduct,width: 100.0,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make():
                      Image.network(controller.snapshotData['imageUrl'],width: 100.0,).box.roundedFull.clip(Clip.antiAlias).make(),
                      title: boldText(text:"${controller.snapshotData['vendor_name']}"),
                      subtitle: normalText(text: "${controller.snapshotData['email']}"),
                    ),
                    Divider(),
                    10.heightBox,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children:List.generate(profileButtonsIcons.length, (index) => ListTile(
                          onTap: (){
                            switch(index){
                              case 0:Get.to(()=>ShopSettings());
                              break;
                              case 1:Get.to(()=>Messages());
                              break;
                              default:break;

                            }
                          },
                          leading: Icon(profileButtonsIcons[index],color: white,),
                          title: normalText(text: profileButtonsTitles[index]),
                        )),
                      ),
                    )


                  ],

                );
              }

            })
      );

  }
}
