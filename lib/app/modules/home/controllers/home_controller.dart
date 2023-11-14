import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/app/data/models/book_model.dart';
import 'package:firebase_app/app/data/models/read_model.dart';
import 'package:firebase_app/app/modules/form/controllers/form_controller.dart';
import 'package:firebase_app/app/modules/login/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Future<QuerySnapshot<Object?>> getData() async {
  //   CollectionReference books = firestore.collection('book');

  //   return books.get();
  // }

  // Stream<QuerySnapshot<Object?>> streamData() {
  //   CollectionReference books = firestore.collection('book');

  //   return books.snapshots();
  // }

  RxList<BookModel> rxBooks = RxList<BookModel>();
  List<BookModel> get book => rxBooks.value;
  set book(List<BookModel> value) => rxBooks.value = value;

  RxList<ReadModel> rxReads = RxList<ReadModel>();
  List<ReadModel> get listread => rxReads.value;
  set listread(List<ReadModel> value) => rxReads.value = value;

  final RxInt showOverlay = (-1).obs;

  String? BookID;

  String? bookid;
  BookModel? selectedbook;

  var isSaving = false.obs;

  TextEditingController bTitleC = TextEditingController();
  TextEditingController prevPR = TextEditingController();
  TextEditingController newPR = TextEditingController();

  controllerToModel(ReadModel read) {
    // read.id = bookid;
    read.bookId = bookid;
    read.prePage = int.tryParse(prevPR.text);
    read.newPage = int.tryParse(newPR.text);
    read.time = DateTime.now();
    return read;
  }

  modelToContoller(ReadModel read) {
    bTitleC.text = read.bookId ?? '';
    prevPR.text = (read.prePage ?? '').toString();
    newPR.text = (read.newPage ?? '').toString();
  }

  Future store(ReadModel read) async {
    isSaving.value = true;
    read = controllerToModel(read);
    try {
      await read.save();
      selectedbook!.readPage = read.newPage;
      await selectedbook?.save();
      toast('Data berhasil diperbarui');
      Get.back();
      Get.back();
    } catch (e) {
      print(e);
      toast('Error ${e.toString()}');
    } finally {
      isSaving.value = false;
    }
  }

  Future delete(BookModel book) async {
    if (book.id != null) {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Book ID not found',
        onConfirm: () => Get.back(),
        textConfirm: 'Okay',
        buttonColor: Color(0xff8332A6),
        confirmTextColor: Colors.white,
        cancelTextColor: Color(0xff8332A6),
        titleStyle: TextStyle(color: Color(0xff8332A6)),
        middleTextStyle: TextStyle(color: Color(0xff8332A6)),
      );
      return Future.value(null);
    }
    try {
      Get.defaultDialog(
        onConfirm: () async {
          try {
            await book.delete(book.id ?? '');
            Get.back();
            Get.back();
          } catch (e) {
            print(e);
          }
        },
        onCancel: () {
          Get.back();
          Get.back();
        },
        textConfirm: "Yes",
        textCancel: "Cancel",
        title: "Delete Book",
        middleText: "Are you sure?",
        buttonColor: Color(0xff8332A6),
        confirmTextColor: Colors.white,
        cancelTextColor: Color(0xff8332A6),
        titleStyle: TextStyle(color: Color(0xff8332A6)),
        middleTextStyle: TextStyle(color: Color(0xff8332A6)),
      );
    } on Exception catch (e) {
      Get.defaultDialog(
        title: "Error",
        middleText: "Failed to delete",
        onConfirm: () => Get.back(),
        textConfirm: "Okay",
        buttonColor: Color(0xff8332A6),
        confirmTextColor: Colors.white,
        cancelTextColor: black,
        titleStyle: TextStyle(color: Color(0xff8332A6)),
        middleTextStyle: TextStyle(color: Color(0xff8332A6)),
      );
    }
  }

  Future deleteread(ReadModel read) async {
    if (read.id == null) {
      Get.defaultDialog(
        title: "Error",
        middleText: "Book ID not found",
        onConfirm: () => Get.back(),
        textConfirm: "Okay",
        buttonColor: Color(0xff8332A6),
        confirmTextColor: Colors.white,
        cancelTextColor: black,
        titleStyle: TextStyle(color: Color(0xff8332A6)),
        middleTextStyle: TextStyle(color: Color(0xff8332A6)),
      );
      return Future.value(null);
    }
    try {
      await read.delete();
    } on Exception catch (e) {
      Get.defaultDialog(
        title: "Error",
        middleText: "Failed to delete ${e}",
        onConfirm: () => Get.back(),
        textConfirm: "Okay",
        buttonColor: Color(0xff8332A6),
        confirmTextColor: Colors.white,
        cancelTextColor: black,
        titleStyle: TextStyle(color: Color(0xff8332A6)),
        middleTextStyle: TextStyle(color: Color(0xff8332A6)),
      );
    }
  }

  //   modelToContoller(BookModel book) {
  //   bookC.titleC.text = book.title ?? '';
  //   bookC.categoryC.text = book.category ?? '';
  //   bookC.pageC.text = (book.page ?? '').toString();
  //   bookC.addImage.value = book.image ?? '';
  // }

  // Future store(BookModel book) async {
  //   isSaving.value = true;
  //   book.title = bookC.titleC.text;
  //   book.category = bookC.categoryC.text;
  //   book.page = int.tryParse(bookC.pageC.text);
  //   book.image = bookC.addImage.value;
  //   try {
  //     await book.save();
  //     toast("Data Berhasil Diperbarui");
  //     Get.back();
  //   } catch (e) {
  //     print(e);
  //     toast("Error ${e.toString()}");
  //   } finally {
  //     isSaving.value = false;
  //   }
  // }

  @override
  void onInit() {
    rxBooks.bindStream(BookModel().streamList());
    rxReads.bindStream(ReadModel().streamAllList());
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
}
