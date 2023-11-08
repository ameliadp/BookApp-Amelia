import 'package:firebase_app/app/addition/bottomnav.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFBF2FF),
      // appBar: AppBar(
      //   title: const Text('ProfileView'),
      //   centerTitle: true,
      // ),
      body: Center(
        child: Stack(
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
                      padding: const EdgeInsets.only(left: 20, top: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 40,
                            backgroundImage:
                                AssetImage('assets/images/avatar.png'),
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
                                'Full Name',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.0),
                              ),
                              Text(
                                'name@gmail.com',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0),
                              )
                            ],
                          ),
                          SizedBox(width: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 85),
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.transparent,
                                  border:
                                      Border.all(color: Colors.white, width: 1),
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
                                  '7',
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
                                  '77%',
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
                                size: 40,
                              ),
                              SizedBox(width: 30),
                              Text(
                                'uremail@gmail.com',
                                style: TextStyle(fontSize: 20),
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
                                size: 40,
                              ),
                              SizedBox(width: 30),
                              Text(
                                'Friday, May 1',
                                style: TextStyle(fontSize: 20),
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
                                Icons.male,
                                color: Color(0xff8332A6),
                                size: 40,
                              ),
                              SizedBox(width: 30),
                              Text(
                                'Male',
                                style: TextStyle(fontSize: 20),
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
                                Icons.female,
                                color: Color(0xff8332A6),
                                size: 40,
                              ),
                              SizedBox(width: 30),
                              Text(
                                'Female',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(initialindex: 1),
    );
  }
}
