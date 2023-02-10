import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nextshop_seller/const/const.dart';

import '../../controllers/profile_controller.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/text_style.dart';
class EditProfileScreen extends StatefulWidget {
  final String? username;
  const EditProfileScreen({Key? key,this.username}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var controller=Get.find<ProfileController>();
  @override
  void initState() {
    controller.nameController.text=widget.username!;
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {

    return Obx(()=>
       Scaffold(
        resizeToAvoidBottomInset: false,

        backgroundColor: purpleColor,
        appBar: AppBar(
         // automaticallyImplyLeading: false,

          title: boldText(text: editProfile,size: 16.0),
          actions: [
            controller.isloading.value?loadingIndicator(circleColor: white):

            TextButton(onPressed: ()async{

              controller.isloading(true);
              //if image is not selected
              if(controller.accountImgPath.value.isNotEmpty){

                await controller.uploadProfileImage();
              }else
              {
                controller.accountImgLink=controller.snapshotData['imageUrl'];
              }
              //if old password matches database
              if(controller.snapshotData['password']==controller.oldpassController.text)
              {
                await controller.changeAuthPassword(
                  email: controller.snapshotData['email'],
                  password:controller.oldpassController.text,
                  newpassword: controller.newpassController.text,
                );
                await controller.updateProfile(
                  imgUrl: controller.accountImgLink,
                  name:controller.nameController.text,
                  password:controller.newpassController.text,

                );
                VxToast.show(context, msg:"Updated");
              }

              else if(controller.oldpassController.text.isEmptyOrNull && controller.newpassController.text.isEmptyOrNull)
              {

                await controller.updateProfile(
                  imgUrl: controller.accountImgLink,
                  name:controller.nameController.text,
                  password:controller.snapshotData['password'],

                );
                VxToast.show(context, msg:"Updated");


              }
              else
                {

                   VxToast.show(context, msg:"Some error occurred!");
                  controller.isloading(false);
                }





            }, child:normalText(text: save,color: white))
          ],

        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
            Column(
              children: [
               // Image.asset(imgProduct,width: 150,).box.roundedFull.clip(Clip.antiAlias).make(),

               controller.snapshotData['imageUrl']=='' && controller.accountImgPath.isEmpty?Image.asset(imgProduct,width: 100.0,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make() :

                controller.snapshotData['imageUrl']!='' && controller.accountImgPath.isEmpty?
                    Image.network(controller.snapshotData['imageUrl'],
                    width: 100,
                        fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make()

                    : Image.file(File(controller.accountImgPath.value),
                  width: 100,
                  fit: BoxFit.cover,
                ).box.roundedFull.clip(Clip.antiAlias).make(),
                10.heightBox,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: white,
                  ),


                    onPressed: (){


                    controller.changeImage(context);
                    },
                    child:normalText(text:changeImage,color: fontGrey)),
                10.heightBox,

                customTextField(label: name,hint: "eg.ABC..",controller: controller.nameController),
                30.heightBox,
                Divider(color: white,),
                Align(
                    alignment: Alignment.centerLeft,

                    child: boldText(text: "Change your password",)),
                10.heightBox,
                customTextField(label: password, hint:passwordHint,controller: controller.oldpassController),
                10.heightBox,
                customTextField(label: confirmPassword,hint: passwordHint,controller: controller.newpassController),



              ],
            ),

        ),
      ),
    );
  }
}
