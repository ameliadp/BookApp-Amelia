import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxInt showOverlay = (-1).obs;

  TextEditingController bTitleC = TextEditingController();
  TextEditingController prevPR = TextEditingController();
  TextEditingController newPR = TextEditingController();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
