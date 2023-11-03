import 'package:firebase_app/app/addition/bottomnav.dart';
import 'package:firebase_app/app/modules/login/controllers/login_controller.dart';
import 'package:firebase_app/app/modules/profile/views/profile_view.dart';
import 'package:firebase_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final authC = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.FORM);
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xff8332A6),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Stack(
        children: [
          Container(
            constraints:
                BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffBF2C98), Color(0xff8332A6)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25, top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 30,
                        backgroundImage: AssetImage('assets/images/avatar.png'),
                      ),
                      SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 15),
                          ),
                          Text(
                            'Hai...',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w200,
                                fontSize: 22),
                          ),
                          Text(
                            'Username',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w100,
                                fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(width: 10),
                      Padding(
                        padding: EdgeInsets.only(top: 12, left: 110),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 85,
                          height: 85,
                          child: Center(
                            child: Icon(
                              Icons.notifications_none,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Book List',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w200),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                controller.showOverlay(index);
                              },
                              child: Container(
                                width: 120,
                                height: 100,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Image.asset(
                                          'assets/images/iconBox.png',
                                          width: 80,
                                          height: 60,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Book Name',
                                        style: TextStyle(
                                          color: Color(0xffBF2C98),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Category',
                                        style: TextStyle(
                                          color: Color(0xffBF2C98),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w100,
                                        ),
                                      ),
                                      Text(
                                        '125/250 page',
                                        style: TextStyle(
                                          color: Color(0xffBF2C98),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w100,
                                        ),
                                      ),
                                      SizedBox(height: 17),
                                      Text(
                                        '50%',
                                        style: TextStyle(
                                            color: Color(0xffBF2C98),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w200),
                                      ),
                                      SizedBox(height: 5),
                                      LinearProgressIndicator(
                                        value: 0.5,
                                        backgroundColor: Color(0xffedebeb),
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Color(0xff7C39BF)),
                                        minHeight: 10,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    IndexedStack(
                      children: List.generate(4, (index) {
                        return Obx(() {
                          return Visibility(
                            visible: controller.isOverlayVisible(index),
                            child: Container(
                              color: Color(0xffaf84c2),
                              child: Column(
                                children: [
                                  // Tombol close di pojok kanan atas
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        // Ketika tombol close diklik, sembunyikan overlay
                                        controller.hideOverlay(index);
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  // Konten overlay, termasuk ikon edit
                                  Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        // Tambahkan logika edit di sini
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                      }),
                    )
                  ],
                ),
                SizedBox(height: 8),
                //RECENT ACTIVITY
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: double.infinity,
                  height: 700,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, top: 15, bottom: 15),
                        child: Text(
                          'Recent Activity',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: 20,
                            itemBuilder: (BuildContext context, int index) {
                              Color backgroundColor = index % 2 == 0
                                  ? Color(0xfffcedf9)
                                  : Color(0xfff5daee);
                              return Container(
                                width: double.infinity,
                                height: 50,
                                color: backgroundColor,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Image.asset(
                                        'assets/images/iconBox.png',
                                        width: 50,
                                        height: 50,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Book Name',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          'Tue, 23 Oct 2023, 12/25',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 88),
                                      child: Container(
                                        width: 50,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: Color(0xffBF2C98),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '1-20',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () => authC.logout(),
              icon: Icon(Icons.logout),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNav(initialindex: 0),
    );
  }
}
