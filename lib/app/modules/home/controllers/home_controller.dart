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

  Future<QuerySnapshot<Object?>> getData() async {
    CollectionReference books = firestore.collection('book');

    return books.get();
  }

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference books = firestore.collection('book');

    return books.snapshots();
  }

  RxList<BookModel> rxBooks = RxList<BookModel>();
  List<BookModel> get book => rxBooks.value;
  set book(List<BookModel> value) => rxBooks.value = value;

  final RxInt showOverlay = (-1).obs;

  String? BookID;

  String? bookid;
  BookModel? selectedbook;


  var isSaving = false.obs;

  TextEditingController bTitleC = TextEditingController();
  TextEditingController prevPR = TextEditingController();
  TextEditingController newPR = TextEditingController();

  controllerToModel(ReadModel read) async {
    read.id = bookid;
    read.bookId = bookid;
    read.prePage = int.tryParse(prevPR.text);
    read.newPage = int.tryParse(newPR.text);
    read.time = DateTime.now();
  }

  modelToContoller(ReadModel read) {
    bTitleC.text = read.bookId ?? '';
    prevPR.text = (read.prePage ?? '').toString();
    newPR.text = (read.newPage ?? '').toString();
  }

  Future store(ReadModel read, BookModel book) async {
    isSaving.value = true;
    read.id = read.id;
    read.bookId = bTitleC.text;
    read.newPage = int.tryParse(newPR.text);
    read.prePage = int.tryParse(prevPR.text);
    read.time = DateTime.now();
    try {
      await read.save();
      toast('Data berhasil diperbarui');
      Get.back();
    } catch (e) {
      print(e);
      toast('Error ${e.toString()}');
    } finally {
      isSaving.value = false;
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
