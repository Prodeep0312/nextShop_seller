import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:nextshop_seller/const/const.dart';
import 'package:nextshop_seller/views/order_screen/order_screen.dart';

import '../../controllers/home_controller.dart';
import '../products_screen/products_screen.dart';
import '../profile_screen/profile_screen.dart';
import 'home_screen.dart';
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(HomeController());
    var navScreens=[
      HomeScreen(),ProductsScreen(),OrdersScreen(),ProfileScreen()
    ];
    var bottomNavbar=[
      BottomNavigationBarItem(icon: Icon(Icons.home),label: dashboard),
      BottomNavigationBarItem(icon: Image.asset(icProducts,color: darkGrey,width: 24,),label: products),
      BottomNavigationBarItem(icon: Image.asset(icOrders,color: darkGrey,width: 24,),label: orders),
      BottomNavigationBarItem(icon: Image.asset(icGeneralSettings,color: darkGrey,width: 24,),label: settings),
    ];
    return Scaffold(
      bottomNavigationBar: Obx(()=>
         BottomNavigationBar(
          onTap: (index){
            controller.navIndex.value=index;
          },
             currentIndex: controller.navIndex.value,
          type: BottomNavigationBarType.fixed,
            selectedItemColor: purpleColor,
            unselectedItemColor: darkGrey,
            items: bottomNavbar),
      ),
      body: Column(
        children: [
          Obx(()=> Expanded(child: navScreens.elementAt(controller.navIndex.value)))
        ],
      )
    );
  }
}
