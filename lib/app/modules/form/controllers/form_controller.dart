import 'dart:io';

import 'package:firebase_app/app/data/models/book_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

class FormController extends GetxController {
  final GlobalKey<FormState> booksForm = GlobalKey<FormState>();

  TextEditingController titleC = TextEditingController();
  TextEditingController categoryC = TextEditingController();
  TextEditingController pageC = TextEditingController();

  var currBook = BookModel().obs;
  BookModel get book => currBook.value;
  set user(BookModel value) => currBook.value = value;

  Rxn<String> _selectedValue = Rxn<String>();
  String? get selectedValue => _selectedValue.value;
  set selectedValue(String? value) => _selectedValue.value = value;

  XFile? image;
  RxString addImage = ''.obs;

  Future getImage() async {
    final ImagePicker picker = ImagePicker();
    image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      addImage.value = image!.path;
    }
  }

  var isSaving = false.obs;

  controllerToModel(BookModel book) async {
    book.title = titleC.text;
    book.category = selectedValue;
    book.page = int.tryParse(pageC.text);
    book.readPage = 0;
    book.image = addImage.value;
    book.time = DateTime.now();
    if (book.id != null) {
      book.time = DateTime.now();
    }
    return book;
  }

  modelToContoller(BookModel book) {
    titleC.text = book.title ?? '';
    categoryC.text = book.category ?? '';
    pageC.text = (book.page ?? '').toString();
    addImage.value = book.image ?? '';
  }

  Future store(BookModel book, {String? path}) async {
    isSaving.value = true;
    File? data;
    book = await controllerToModel(book);
    if (!path.isEmptyOrNull) {
      data = File(path!);
    }
    try {
      data == null ? await book.save() : await book.save(file: data);
      toast('Data berhasil diperbarui');
      Get.back();
    } catch (e) {
      print(e);
      toast('Error ${e.toString()}');
    } finally {
      isSaving.value = false;
    }
  }

  checkControllers(BookModel book, String? path) {
    if (book.id.isEmptyOrNull) {
      if (titleC.text.isNotEmpty ||
          categoryC.text.isNotEmpty ||
          pageC.text.isNotEmpty ||
          (path == null || path == '')) return true;
    }
    return false;
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
}
