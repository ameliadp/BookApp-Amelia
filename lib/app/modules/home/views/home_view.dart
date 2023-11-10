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
import 'package:nb_utils/nb_utils.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  GlobalKey<FormState> formKey = GlobalKey();
  final authC = Get.find<LoginController>();
  BookModel book = Get.arguments ?? BookModel();
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 5, bottom: 10),
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
                                  await controller.store(read, book);
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
                            child: Text('Submit'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 5, right: 10, bottom: 10),
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
        child: Icon(Icons.add),
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
                  height: 220,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: StreamBuilder<QuerySnapshot<Object?>>(
                        stream: controller.streamData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            var listAllBook = snapshot.data!.docs;
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: listAllBook.length,
                              itemBuilder: (context, index) {
                                return Obx(() {
                                  return GestureDetector(
                                    onTap: () {
                                      controller.showOverlay.value = index;
                                    },
                                    child: controller.showOverlay.value == index
                                        ? Container(
                                            width: 125,
                                            height: 200,
                                            decoration: BoxDecoration(
                                              color: Color(0xff8332A6)
                                                  .withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Stack(
                                              children: [
                                                Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          Get.toNamed(
                                                                  Routes.FORM,
                                                                  arguments:
                                                                      book)
                                                              ?.then((update) {
                                                            if (update !=
                                                                    null &&
                                                                update
                                                                    is BookModel) {}
                                                          });
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              Icons.edit,
                                                              color:
                                                                  Colors.white,
                                                              size: 20,
                                                            ),
                                                            SizedBox(width: 10),
                                                            Text(
                                                              'Edit',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 15),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      InkWell(
                                                        onTap: () {},
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              Icons.delete,
                                                              color:
                                                                  Colors.white,
                                                              size: 20,
                                                            ),
                                                            SizedBox(width: 10),
                                                            Text(
                                                              'Delete',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
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
                                                      controller.showOverlay
                                                          .value = -1;
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
                                                    child: Image.network(
                                                      '${(listAllBook[index].data() as Map<String, dynamic>)['image']}',
                                                      width: 90,
                                                      height: 80,
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    '${(listAllBook[index].data() as Map<String, dynamic>)['title']}',
                                                    style: TextStyle(
                                                      color: Color(0xffBF2C98),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${(listAllBook[index].data() as Map<String, dynamic>)['category']}',
                                                    style: TextStyle(
                                                      color: Color(0xffBF2C98),
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w100,
                                                    ),
                                                  ),
                                                  Text(
                                                    '125/${(listAllBook[index].data() as Map<String, dynamic>)['page']} page',
                                                    style: TextStyle(
                                                      color: Color(0xffBF2C98),
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w100,
                                                    ),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    '50%',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xffBF2C98),
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w200),
                                                  ),
                                                  SizedBox(height: 5),
                                                  LinearProgressIndicator(
                                                    value: 0.5,
                                                    backgroundColor:
                                                        Color(0xffedebeb),
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                                Color>(
                                                            Color(0xff7C39BF)),
                                                    minHeight: 10,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                  );
                                });
                              },
                            );
                          }
                          return Center(child: CircularProgressIndicator());
                        }),
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
                  height: 700,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, top: 15, bottom: 15),
                        child: Text(
                          'Recent Activity',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 650,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: 20,
                            itemBuilder: (BuildContext context, int index) {
                              Color backgroundColor = index % 2 == 0
                                  ? Color(0xffBF2C98).withOpacity(0.1)
                                  : Color(0xffBF2C98).withOpacity(0.2);
                              return Container(
                                margin: EdgeInsets.all(0),
                                width: double.infinity,
                                height: 50,
                                color: backgroundColor,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Image.asset(
                                        'assets/images/iconBox.png',
                                        width: 50,
                                        height: 50,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Book Name',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          'Tue, 23 Oct 2023, 12/25',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 88),
                                      child: Container(
                                        width: 50,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: Color(0xffBF2C98),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '1-20',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
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
              icon: Icon(Icons.logout),
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
