import 'dart:io';

import 'package:firebase_app/app/data/models/book_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/form_controller.dart';

class FormView extends GetView<FormController> {
  GlobalKey<FormState> formKey = GlobalKey();
  BookModel book = Get.arguments ?? BookModel();
  FormView({super.key});
  final categories = [
    'Novel',
    'Comic',
    'Ensiklopedia',
    'Biografi',
    'Antologi',
    'CerPen',
    'Pendidikan',
    'Motivasi',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFBF2FF),
      appBar: AppBar(
        backgroundColor: Color(0xffFBF2FF),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xff7C39BF),
          ),
        ),
        title: const Text(
          "Book's Form",
          style: TextStyle(
            color: Color(0xff7C39BF),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                child: Card(
                  elevation: 9,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Form(
                      key: formKey,
                      autovalidateMode: AutovalidateMode.always,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8, right: 8, top: 5),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.book_rounded,
                                  color: Color(0xff8332A6),
                                ),
                                SizedBox(width: 10),
                                SizedBox(
                                  height: 60,
                                  width: 220,
                                  child: TextFormField(
                                    controller: controller.titleC,
                                    autocorrect: false,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      labelText: 'Title',
                                      labelStyle:
                                          TextStyle(color: Color(0xff8332A6)),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff8332A6)),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff8332A6)),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff8332A6)),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Title wajib diisi';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 8, right: 30, top: 5),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.category_rounded,
                                  color: Color(0xff8332A6),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Obx(() => DropdownButtonFormField<String>(
                                            itemHeight: 50,
                                            value: controller.selectedValue
                                                        ?.isNotEmpty ==
                                                    true
                                                ? controller.selectedValue
                                                : null,
                                            items: categories
                                                .map((String category) {
                                              return DropdownMenuItem<String>(
                                                value: category,
                                                child: Text(category),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              if (newValue != null) {
                                                controller.selectedValue =
                                                    newValue;
                                              }
                                            },
                                            decoration: InputDecoration(
                                              labelText: 'Category',
                                              labelStyle: TextStyle(
                                                  color: Color(0xff8332A6)),
                                              border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xff8332A6)),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xff8332A6)),
                                              ),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xff8332A6)),
                                              ),
                                              alignLabelWithHint: true,
                                            ),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Category wajib di isi';
                                              }
                                              return null;
                                            },
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 8, right: 8, top: 8, bottom: 5),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.label_important_outlined,
                                  color: Color(0xff8332A6),
                                ),
                                SizedBox(width: 10),
                                SizedBox(
                                  height: 60,
                                  width: 220,
                                  child: TextFormField(
                                    controller: controller.pageC,
                                    autocorrect: false,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      labelText: 'Page Count',
                                      labelStyle:
                                          TextStyle(color: Color(0xff8332A6)),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff8332A6)),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff8332A6)),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff8332A6)),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Jumlah halaman wajib di isi';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              controller.addImage.value.isNotEmpty
                  ? Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Card(
                        elevation: 9,
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Center(
                            child: Image.file(File(controller.addImage.value),
                                fit: BoxFit.contain),
                          ),
                        ),
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Card(
                        elevation: 9,
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20, top: 20),
                              child: Text(
                                "Book's Cover",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            Center(
                              child: Image.asset(
                                'assets/images/formIcon.png',
                                width: 200,
                                height: 200,
                                // fit: BoxFit.contain,
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(100, 30),
                                    backgroundColor: Color(0xff8332A6),
                                    side: BorderSide(
                                      color: Color(0xff8332A6),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () async {
                                    await controller.getImage();
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(
                                        Icons.cloud_upload_outlined,
                                        color: Colors.white,
                                        size: 19,
                                      ),
                                      Text(
                                        'Upload',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 12, right: 12),
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() == true) {
                      controller.store(book, path: controller.addImage.value);
                    } else {
                      Get.defaultDialog(
                        title: 'Gagal!',
                        middleText: 'Data tidak berhasil disimpan',
                        middleTextStyle: TextStyle(color: Color(0xff8332A6)),
                        onConfirm: () {
                          Get.back();
                        },
                        textConfirm: 'Oke',
                        buttonColor: Color(0xff8332A6),
                        confirmTextColor: Colors.white,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 8,
                    shadowColor: Colors.grey,
                    backgroundColor: Color(0xff8332A6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    minimumSize: Size(double.infinity, 45),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
