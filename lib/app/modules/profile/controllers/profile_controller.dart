import 'package:firebase_app/app/data/database.dart';
import 'package:firebase_app/app/data/models/book_model.dart';
import 'package:firebase_app/app/integrations/firestore.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxList<BookModel> rxBooks = RxList<BookModel>();
  List<BookModel> get books => rxBooks.value;
  set books(List<BookModel> value) => rxBooks.value = value;

  final count = 0.obs;
  @override
  void onInit() {
    rxBooks.bindStream(BookModel().streamList());
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
