import 'package:get/get.dart';

class HomeController extends GetxController {
  var overlayVisible = List.generate(4, (index) => false).obs;

  void showOverlay(int index) {
    overlayVisible[index] = true;
  }

   void hideOverlay(int index) {
    overlayVisible[index] = false;
  }

  bool isOverlayVisible(int index) {
    return overlayVisible[index];
  }

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
