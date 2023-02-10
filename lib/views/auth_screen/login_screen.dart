import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nextshop_seller/const/const.dart';
import 'package:nextshop_seller/controllers/auth_controller.dart';

import '../home_screen/home.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/our_button.dart';
import '../widgets/text_style.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(AuthController());
    return Scaffold(
      resizeToAvoidBottomInset: false,//to avoid pixel overflow
      backgroundColor: purpleColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              30.heightBox,
                normalText(text: welcome,size: 18.0),
              20.heightBox,
              Row(
                children: [
                  Image.asset(icLogo,
                    height: 70,
                    width: 70,).box.border(color:white).rounded.padding(EdgeInsets.all(8)).make(),
                  10.widthBox,
                  boldText(text: appname,size: 20.0),
                ],
              ),
              40.heightBox,
              normalText(text: loginTo,size: 18.0,color: lightGrey),
              10.heightBox,

              Obx(()=>
                 Column(
                  children: [
                    TextFormField(
                      controller:controller.emailController,

                      decoration: InputDecoration(
                        filled: true,
                        fillColor: textfieldGrey,
                        prefixIcon: Icon(Icons.email,color: purpleColor),
                        hintText:emailHint,
                        border: InputBorder.none,
                      ),

                    ),

                    TextFormField(
                      obscureText: true,
                      controller: controller.passwordController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: textfieldGrey,
                        prefixIcon: Icon(Icons.lock,color: purpleColor),
                        hintText:passwordHint,
                        border: InputBorder.none,
                      ),

                    ),
                    Align(
                      alignment: Alignment.centerRight,

                        child: TextButton(onPressed: (){}, child: normalText(text: forgotPassword,color: purpleColor))),
                    20.heightBox,
                    SizedBox(
                      width: context.screenWidth-100,
                        child: controller.isloading.value ? loadingIndicator():
                        ourButton(title: login,onPress: ()async{
                          //Get.to(()=>Home());

                          controller.isloading(true);

                          await controller.loginMethod(context: context).then((value){
                            if(value!=null){
                              VxToast.show(context, msg: "Logged in");
                              controller.isloading(false);
                              Get.offAll(()=>Home());
                            }
                            else{
                              controller.isloading(false);
                            }
                          });




                        }))
                  ],
                ).box.outerShadowMd.white.rounded.padding(EdgeInsets.all(8)).make(),
              ),
              10.heightBox,
              Center(child: normalText(text: anyProblem,color: lightGrey)),
              Spacer(),
              Center(child: boldText(text: credit)),
              20.heightBox,


            ],
          ),
        ),
      ),
    );
  }
}
