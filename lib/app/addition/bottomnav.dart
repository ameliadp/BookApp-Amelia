import 'package:firebase_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  BottomNav({this.initialindex});
  int? initialindex;

  RxInt currentIndex = 0.obs;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(
          () => BottomAppBar(
            notchMargin: 5.0,
            shape: CircularNotchedRectangle(),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    currentIndex.value = 0;
                    Get.toNamed(Routes.HOME);
                  },
                  icon: Icon(
                    Icons.home_rounded,
                    color: currentIndex.value == 0
                        ? Color(0xff8332A6)
                        : Colors.grey,
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    currentIndex.value = 1;
                    Get.toNamed(Routes.PROFILE);
                  },
                  icon: Icon(
                    Icons.person,
                    color: currentIndex.value == 1
                        ? Color(0xff8332A6)
                        : Colors.grey,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
