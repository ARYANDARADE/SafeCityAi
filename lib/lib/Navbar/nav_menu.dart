import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:police_app/Pages/Map/map.dart';
import 'package:police_app/screens/home_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:police_app/Pages/Home/Home.dart';

import '../Pages/Wallet/Wallet.dart';
class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context){
    final controller = Get.put(NavigationController());

    return Scaffold(
      backgroundColor: Colors.black45,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          color: Color(0xff1F1F21),//Color(0xff4A8CB0),
        ),
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
        child: Obx(
          ()=>SalomonBottomBar(
            currentIndex: controller.currentIndex.value,
            onTap:(index) => controller.currentIndex.value = index,
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: Icon(Icons.home,size: 27,),
              title: Text("Home"),
              selectedColor: Colors.white,
              unselectedColor: Color(0xff4A8CB0),
            ),


            /// Search
            SalomonBottomBarItem(
              icon: Icon(Icons.chat_rounded,size: 25,),
              title: Text("Chat"),
              selectedColor: Colors.white,
              unselectedColor: Color(0xff4A8CB0),
            ),

            /// Profile
            SalomonBottomBarItem(
              icon: const Icon(Icons.map_rounded,size: 25,),
              title: const Text("Map"),
              selectedColor: Colors.white,
              unselectedColor: const Color(0xff4A8CB0),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.account_balance_wallet_outlined,size: 25,),
              title: const Text("Map"),
              selectedColor: Colors.white,
              unselectedColor: Color(0xff4A8CB0),
            ),
          ],
        ),
        ),
      ),
      body: Obx(()=> controller.screens[controller.currentIndex.value]),
    );
  }

}

class NavigationController extends GetxController{
  final Rx<int> currentIndex= 0.obs;

  final screens = [const HomePage(),const HomeScreen(),const MapPage(),WalletPage()];
}