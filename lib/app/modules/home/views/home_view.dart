import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_app/app/addition/bottomnav.dart';
import 'package:firebase_app/app/data/models/book_model.dart';
import 'package:firebase_app/app/data/models/read_model.dart';
import 'package:firebase_app/app/modules/form/controllers/form_controller.dart';
import 'package:firebase_app/app/modules/login/controllers/login_controller.dart';
import 'package:firebase_app/app/modules/profile/views/profile_view.dart';
import 'package:firebase_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  GlobalKey<FormState> formKey = GlobalKey();
  final authC = Get.find<LoginController>();
  // BookModel book = Get.arguments ?? BookModel();
  ReadModel read = Get.arguments ?? ReadModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //BUTTON ADD
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  title: Center(
                    child: Text(
                      'Reading Form',
                      style: TextStyle(color: Color(0xff8332A6)),
                    ),
                  ),
                  content: Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: Container(
                      width: 800,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          _buildTextFieldOne('Select Book', controller),
                          _buildTextFieldTwo('Previous Read Page', controller),
                          _buildTextFieldThree('Newest Read Page', controller),
                        ],
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 5,
                              shadowColor: Color(0xff8332A6),
                              backgroundColor: Color(0xff8332A6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              minimumSize: Size(140, 40),
                            ),
                            onPressed: () async {
                              if (formKey.currentState?.validate() == true) {
                                if (controller.isSaving.value == false) {
                                  await controller.store(read);
                                } else {
                                  Get.defaultDialog(
                                    title: 'Gagal!',
                                    middleText: 'Data tidak berhasil disimpan',
                                    middleTextStyle:
                                        TextStyle(color: Color(0xff8332A6)),
                                    onConfirm: () {
                                      Get.back();
                                    },
                                    textConfirm: 'Oke',
                                    buttonColor: Color(0xff8332A6),
                                    confirmTextColor: Colors.white,
                                  );
                                }
                              }
                            },
                            child: Text(
                              'Submit',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 3,
                              shadowColor: Color(0xff8332A6),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Color(0xff8332A6)),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              minimumSize: Size(80, 40),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(color: Color(0xff8332A6)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              });
        },
        shape: CircleBorder(),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color(0xff8332A6),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Stack(
        children: [
          //BACKGROUND COLOR
          Container(
            constraints:
                BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffBF2C98), Color(0xff8332A6)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                //AVATAR & USERNAME
                Padding(
                  padding: const EdgeInsets.only(left: 25, top: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 30,
                            backgroundImage: AssetImage(
                                authC.user.gender == 'male'
                                    ? 'assets/images/avatarCowo.png'
                                    : 'assets/images/avatarCewe.png'),
                          ),
                          SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hai...',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200,
                                    fontSize: 22),
                              ),
                              Obx(
                                () => Text(
                                  '${authC.user.username}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w100,
                                      fontSize: 16),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.notifications_none,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          SizedBox(width: 18),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                //BOOK LIST
                Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Book List',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w200),
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.FORM);
                        },
                        child: Icon(
                          Icons.add_circle_outline_outlined,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                //LISTVIEW BUILDER >> HORIZONTAL
                Container(
                  width: double.infinity,
                  height: 225,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Obx(
                      () => ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.book.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Obx(() => GestureDetector(
                                onTap: () {
                                  controller.showOverlay.value = index;
                                },
                                child: controller.showOverlay.value == index
                                    ? Container(
                                        width: 125,
                                        height: 200,
                                        margin: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Color(0xff8332A6)
                                              .withOpacity(0.9),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Stack(
                                          children: [
                                            Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      Get.toNamed(Routes.FORM,
                                                          arguments: controller
                                                              .book[index]);
                                                      //       ?.then((update) {
                                                      //     if (update != null &&
                                                      //         update
                                                      //             is BookModel) {}
                                                      //   });
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.edit,
                                                          color: Colors.white,
                                                          size: 20,
                                                        ),
                                                        SizedBox(width: 10),
                                                        Text(
                                                          'Edit',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  InkWell(
                                                    onTap: () {
                                                      controller.delete(
                                                          controller
                                                              .book[index]);
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.delete,
                                                          color: Colors.white,
                                                          size: 20,
                                                        ),
                                                        SizedBox(width: 10),
                                                        Text(
                                                          'Delete',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              top: 10,
                                              right: 10,
                                              child: GestureDetector(
                                                onTap: () {
                                                  controller.showOverlay.value =
                                                      -1;
                                                },
                                                child: Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: Colors.white,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.close_rounded,
                                                      color: Colors.white,
                                                      size: 13,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(
                                        width: 125,
                                        height: 200,
                                        margin: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Center(
                                                child: controller.book[index]
                                                        .image.isEmptyOrNull
                                                    ? Image.asset(
                                                        'assets/images/iconBox.png',
                                                        width: 80,
                                                        height: 60,
                                                      )
                                                    : Image.network(
                                                        '${controller.book[index].image}',
                                                        width: 90,
                                                        height: 80,
                                                      ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                '${controller.book[index].title}',
                                                style: TextStyle(
                                                  color: Color(0xffBF2C98),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                '${controller.book[index].category}',
                                                style: TextStyle(
                                                  color: Color(0xffBF2C98),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w100,
                                                ),
                                              ),
                                              Text(
                                                '${controller.book[index].readPage}/${controller.book[index].page} page',
                                                style: TextStyle(
                                                  color: Color(0xffBF2C98),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w100,
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                NumberFormat.percentPattern(
                                                        'id')
                                                    .format((controller
                                                                .book[index]
                                                                .readPage ??
                                                            0) /
                                                        (controller.book[index]
                                                                .page ??
                                                            0)),
                                                style: TextStyle(
                                                    color: Color(0xffBF2C98),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w200),
                                              ),
                                              SizedBox(height: 5),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                child: LinearProgressIndicator(
                                                  value: (controller.book[index]
                                                              .readPage ??
                                                          0) /
                                                      (controller.book[index]
                                                              .page ??
                                                          0),
                                                  backgroundColor:
                                                      Color(0xffedebeb),
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                              Color>(
                                                          Color(0xff7C39BF)),
                                                  minHeight: 10,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                              ));
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                //RECENT ACTIVITY
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: double.infinity,
                  height: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, top: 15, bottom: 15),
                            child: Text(
                              'Recent Activity',
                              style: TextStyle(
                                  color: Color(0xFF8332A6), fontSize: 20),
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.menu_book_outlined,
                              color: Color(0xFF8332A6)),
                        ],
                      ),
                      Obx(
                        () => controller.listread.length < 1
                            ? Center(
                                child: Text('No Read Found',
                                    style: TextStyle(color: Color(0xff7c39bf))),
                              )
                            : Expanded(
                                child: Container(
                                  height: 650,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemCount: controller.listread.length,
                                    itemBuilder: (context, index) {
                                      Color backgroundColor = index % 2 == 0
                                          ? Color(0xffBF2C98).withOpacity(0.1)
                                          : Color(0xffBF2C98).withOpacity(0.2);
                                      ReadModel read =
                                          controller.listread[index];
                                      BookModel? book = controller.book
                                          .firstWhereOrNull((element) =>
                                              element.id ==
                                              controller
                                                  .listread[index].bookId);
                                      return Dismissible(
                                        key: Key(index.toString()),
                                        confirmDismiss: (direction) async {
                                          return await showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                titleTextStyle: TextStyle(
                                                  color: Color(0xFF8332A6),
                                                  fontSize: 20,
                                                ),
                                                contentTextStyle: TextStyle(
                                                  color: Color(0xFF8332A6),
                                                  fontSize: 17,
                                                ),
                                                title: Text("Confirm"),
                                                content: Text(
                                                    "Are you sure to delete this read?"),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(false);
                                                    },
                                                    child: Text(
                                                      "No",
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xFF8332A6)),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(true);
                                                    },
                                                    child: Text(
                                                      "Yes",
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xFF8332A6)),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        onDismissed: (direction) async {
                                          await controller.deleteread(
                                              controller.listread[index]);
                                          controller.listread.removeAt(index);
                                          // controller.listread.refresh();
                                        },
                                        background: Container(
                                          color: Color(0xFF8332A6),
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                            size: 35,
                                          ),
                                          alignment: Alignment.centerRight,
                                          padding: EdgeInsets.only(right: 20),
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.all(0),
                                          width: double.infinity,
                                          color: backgroundColor,
                                          child: ListTile(
                                            leading:
                                                book?.image.isEmptyOrNull ??
                                                        true
                                                    ? Image.asset(
                                                        'assets/images/iconBox.png',
                                                        width: 60,
                                                        height: 60,
                                                        fit: BoxFit.contain,
                                                      )
                                                    : Image.network(
                                                        book!.image!,
                                                        height: 65,
                                                        width: 60,
                                                        fit: BoxFit.contain,
                                                      ),
                                            title: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Text(
                                                book?.title ?? 'Book Name',
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            ),
                                            subtitle: Text(
                                                '${DateFormat.yMMMEd().format(read.time!)}  ${read.prePage}/${read.newPage}'),
                                            trailing: Container(
                                              width: 50,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                color: Color(0xffBF2C98),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  '${read.prePage} - ${read.newPage}',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () => authC.logout(),
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNav(initialindex: 0),
    );
  }
}

Widget _buildTextFieldOne(String label, HomeController controller) {
  return Padding(
    padding: const EdgeInsets.only(left: 3, right: 3, top: 5),
    child: Row(
      children: [
        Icon(
          Icons.book_rounded,
          color: Color(0xff8332A6),
        ),
        SizedBox(width: 10),
        SizedBox(
          height: 60,
          width: 180,
          child: DropdownSearch<BookModel>(
            items: controller.book,
            itemAsString: (BookModel) => BookModel.title!,
            onChanged: (BookModel) {
              if (BookModel != null) {
                controller.selectedbook = BookModel;
                controller.bookid = BookModel.id;
                controller.prevPR.text = BookModel.readPage.toString();
              } else {
                toast('Select Book wajib diisi!');
              }
            },
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: 'Category',
                labelStyle: TextStyle(color: Color(0xff8332A6)),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff8332A6)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff8332A6)),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff8332A6)),
                ),
                alignLabelWithHint: true,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// Widget _buildTextFieldOne(String label, HomeController controller) {
//   return Padding(
//     padding: const EdgeInsets.only(left: 3, right: 3, top: 5),
//     child: Row(
//       children: [
//         Icon(
//           Icons.book_rounded,
//           color: Color(0xff8332A6),
//         ),
//         SizedBox(width: 10),
//         SizedBox(
//           height: 60,
//           width: 180,
//           child: DropdownSearch<BookModel>(
//             items: controller.book,
//             itemAsString: (BookModel) => BookModel.title!,
//             onChanged: (BookModel) {
//               controller.selectedbook = BookModel;
//               controller.bookid = BookModel!.id;
//               controller.prevPR.text = BookModel.readPage.toString();
//             },
//           ),
//         ),
//       ],
//     ),
//   );
// }

Widget _buildTextFieldTwo(String label, HomeController controller) {
  return Padding(
    padding: const EdgeInsets.only(left: 3, right: 3, top: 5),
    child: Row(
      children: [
        Icon(
          Icons.label,
          color: Color(0xff8332A6),
        ),
        SizedBox(width: 10),
        SizedBox(
          height: 60,
          width: 180,
          child: TextFormField(
            controller: controller.prevPR,
            autocorrect: false,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 10, bottom: 5),
              labelText: 'Previous Read Page',
              labelStyle: TextStyle(color: Color(0xff8332A6)),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xff8332A6)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xff8332A6)),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xff8332A6)),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Form ini wajib diisi !';
              }
              return null;
            },
          ),
        ),
      ],
    ),
  );
}

Widget _buildTextFieldThree(String label, HomeController controller) {
  return Padding(
    padding: const EdgeInsets.only(left: 3, right: 3, top: 5),
    child: Row(
      children: [
        Icon(
          Icons.label_important_outlined,
          color: Color(0xff8332A6),
        ),
        SizedBox(width: 10),
        SizedBox(
          height: 60,
          width: 180,
          child: TextFormField(
            controller: controller.newPR,
            autocorrect: false,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 10, bottom: 5),
              labelText: 'Newest Read Page',
              labelStyle: TextStyle(color: Color(0xff8332A6)),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xff8332A6)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xff8332A6)),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xff8332A6)),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Form ini wajib diisi !';
              }
              return null;
            },
          ),
        ),
      ],
    ),
  );
}
