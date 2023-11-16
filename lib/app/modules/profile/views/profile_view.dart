import 'package:firebase_app/app/addition/bottomnav.dart';
import 'package:firebase_app/app/modules/login/controllers/login_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final authC = Get.find<LoginController>();
  ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFBF2FF),
      // appBar: AppBar(
      //   title: const Text('ProfileView'),
      //   centerTitle: true,
      // ),
      body: Center(
        child: Obx(
          () => Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/images/bgProfile.png',
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: 300.0,
                ),
              ),
              Column(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 35,
                              backgroundImage: AssetImage(
                                  authC.user.gender == 'male'
                                      ? 'assets/images/avatarCowo.png'
                                      : 'assets/images/avatarCewe.png'),
                            ),
                            SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 12),
                                ),
                                Text(
                                  '${authC.user.username}'.toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18.0),
                                ),
                                Text(
                                  '${authC.user.email}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15.0),
                                )
                              ],
                            ),
                            SizedBox(width: 15),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.transparent,
                                    border: Border.all(
                                        color: Colors.white, width: 1),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 40, left: 15, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 130,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 8,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Total Book',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    controller.books.length.toString(),
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff8332A6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 30),
                            Container(
                              width: 130,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 8,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Total Progres',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    '100%',
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff8332A6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 80),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.email_outlined,
                                  color: Color(0xff8332A6),
                                  size: 30,
                                ),
                                SizedBox(width: 23),
                                Text(
                                  '${authC.user.email}',
                                  style: TextStyle(
                                      fontSize: 15, color: Color(0xff8332A6)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 35),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.cake,
                                  color: Color(0xff8332A6),
                                  size: 30,
                                ),
                                SizedBox(width: 23),
                                Text(
                                  authC.user.birthDate is DateTime
                                      ? DateFormat("EEE, dd MMM y")
                                          .format(authC.selectedDate!)
                                      : '--',
                                  style: TextStyle(
                                      fontSize: 15, color: Color(0xff8332A6)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 35),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  authC.user.gender == 'male'
                                      ? Icons.male
                                      : Icons.female,
                                  color: Color(0xff8332A6),
                                  size: 30,
                                ),
                                SizedBox(width: 23),
                                Text(
                                  authC.user.gender == 'male'
                                      ? 'Male'
                                      : 'Female',
                                  style: TextStyle(
                                      fontSize: 15, color: Color(0xff8332A6)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 35),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNav(initialindex: 1),
    );
  }
}
