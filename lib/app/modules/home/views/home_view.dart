import 'package:firebase_app/app/modules/login/controllers/login_controller.dart';
import 'package:firebase_app/app/modules/profile/views/profile_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final authC = Get.find<LoginController>();

  final TextStyle unselectedLabelStyle = TextStyle(
    color: Colors.white.withOpacity(0.5),
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );
  final TextStyle selectedLabelStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );  

  // buildBottomNavigationMenu(context, HomeController) {
  //   return Obx(
  //     () => MediaQuery(
  //       data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
  //       child: SizedBox(
  //         height: 54,
  //         child: BottomNavigationBar(
  //           showUnselectedLabels: true,
  //           showSelectedLabels: true,
  //           onTap: controller.changeTabIndex,
  //           currentIndex: controller.tabIndex.value,
  //           backgroundColor: Colors.white,
  //           unselectedItemColor: Colors.grey,
  //           selectedItemColor: Color(0xff8332A6),
  //           unselectedLabelStyle: unselectedLabelStyle,
  //           selectedLabelStyle: selectedLabelStyle,
  //           items: [
  //             BottomNavigationBarItem(
  //               icon: Container(
  //                 margin: EdgeInsets.only(bottom: 7),
  //                 child: Icon(Icons.home, size: 20.0),
  //               ),
  //               label: 'Home',
  //               backgroundColor: Colors.white,
  //             ),
  //             BottomNavigationBarItem(
  //               icon: Container(
  //                 margin: EdgeInsets.only(bottom: 7),
  //                 child: Icon(Icons.person, size: 20.0),
  //               ),
  //               label: 'Profile',
  //               backgroundColor: Colors.white,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: buildBottomNavigationMenu(context, controller),
      appBar: AppBar(
        title: const Text('HomeView'),
        actions: [
          IconButton(
            onPressed: () => authC.logout(),
            icon: Icon(Icons.logout),
          )
        ],
        centerTitle: true,
      ),
      body: Text('homeView')
      // Obx(
      //   () => Container(
      //     decoration: BoxDecoration(
      //       gradient: LinearGradient(
      //         colors: [Color(0xffBF2C98), Color(0xff8332A6)],
      //         begin: Alignment.topCenter,
      //         end: AlignmentDirectional.bottomCenter,
      //       ),
      //     ),
      //     child: IndexedStack(
      //       index: controller.tabIndex.value,
      //       children: [HomeView(), ProfileView()],
      //     ),
      //   ),
      // ),
    );
  }
}
