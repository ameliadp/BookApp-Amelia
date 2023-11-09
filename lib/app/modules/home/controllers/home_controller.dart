import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/app/data/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  // RxList<BookModel> rxBook = RxList<BookModel>();
  // List<BookModel> get listBook => rxBook.value;
  // set listBook(List<BookModel> value) => rxBook.value = value;

  final RxInt showOverlay = (-1).obs;

  TextEditingController bTitleC = TextEditingController();
  TextEditingController prevPR = TextEditingController();
  TextEditingController newPR = TextEditingController();

  final count = 0.obs;
  @override
  void onInit() {
    // rxBook.bindStream(BookModel().streamList());
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
