import 'package:firebase_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  GlobalKey<FormState> formKey = GlobalKey();
  LoginView({super.key}) {
    initializeDateFormatting();
  }

  // Future<void> _selectedDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime.now(),
  //   );
  //   if (picked != null) {
  //     final DateFormat formatter = DateFormat('E, dd MMMM yyyy', 'en');
  //     String formattedDate = formatter.format(picked);
  //     controller.birthDateC.text = formattedDate;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFBF2FF),
      body: Obx(
        () => Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/iconLogin.png',
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Card(
                    elevation: 8,
                    shadowColor: Colors.grey,
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
                            if (controller.isRegis)
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 8, right: 8, top: 5),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      color: Color(0xff8332A6),
                                    ),
                                    SizedBox(width: 10),
                                    SizedBox(
                                      height: 60,
                                      width: 220,
                                      child: TextFormField(
                                        controller: controller.nameC,
                                        autocorrect: false,
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              top: 10, bottom: 5),
                                          labelText: 'Username',
                                          labelStyle: TextStyle(
                                              color: Color(0xff8332A6)),
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
                                            return 'Username wajib diisi';
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
                                  EdgeInsets.only(left: 8, right: 8, top: 7),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.email,
                                    color: Color(0xff8332A6),
                                  ),
                                  SizedBox(width: 10),
                                  SizedBox(
                                    height: 60,
                                    width: 220,
                                    child: TextFormField(
                                      controller: controller.emailC,
                                      autocorrect: false,
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(top: 10, bottom: 5),
                                        labelText: 'Email',
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
                                          return 'Harap isi email Anda';
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
                                  EdgeInsets.only(left: 8, right: 8, top: 7),
                              child: Row(
                                children: [
                                  Icon(Icons.lock_outline,
                                      color: Color(0xff8332A6)),
                                  SizedBox(width: 10),
                                  SizedBox(
                                    height: 60,
                                    width: 220,
                                    child: TextFormField(
                                      autocorrect: false,
                                      controller: controller.passC,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      obscureText:
                                          controller.isPasswordHidden.value,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(top: 10, bottom: 5),
                                        labelText: 'Password',
                                        labelStyle:
                                            TextStyle(color: Color(0xff8332A6)),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            controller
                                                .togglePasswordVisibility();
                                          },
                                          icon: Icon(
                                            controller.isPasswordHidden.value
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Color(0xff8332A6),
                                          ),
                                        ),
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
                                          return 'Harap isi password Anda';
                                        }
                                        if (controller.isRegis &&
                                            value != controller.passC2.text) {
                                          return 'Kata sandi tidak cocok';
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
                                  EdgeInsets.only(left: 8, right: 8, top: 7),
                              child: Row(
                                children: [
                                  Icon(Icons.lock_outline,
                                      color: Color(0xff8332A6)),
                                  SizedBox(width: 10),
                                  SizedBox(
                                    height: 60,
                                    width: 220,
                                    child: TextFormField(
                                      autocorrect: false,
                                      controller: controller.passC2,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      obscureText:
                                          controller.isPasswordHidden.value,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(top: 10, bottom: 5),
                                        labelText: 'Confirm Password',
                                        labelStyle:
                                            TextStyle(color: Color(0xff8332A6)),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            controller
                                                .togglePasswordVisibility();
                                          },
                                          icon: Icon(
                                            controller.isPasswordHidden.value
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Color(0xff8332A6),
                                          ),
                                        ),
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
                                          return 'Harap konfirmasi password Anda';
                                        }
                                        if (controller.isRegis &&
                                            value != controller.passC.text) {
                                          return 'Kata sandi tidak cocok';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (controller.isRegis)
                              Container(
                                margin:
                                    EdgeInsets.only(left: 8, right: 8, top: 7),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 24,
                                      alignment: Alignment.centerLeft,
                                      child: Icon(
                                        Icons.calendar_today,
                                        color: Color(0xff8332A6),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
                                      child: Container(
                                        height: 60,
                                        width: 220,
                                        child: ListTile(
                                          onTap: () async => await controller
                                              .handleBirthDate(context),
                                          title: Text(
                                            "Birth Date",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Color(0xff8332A6)),
                                          ),
                                          subtitle: Text(
                                            controller.selectedDate is DateTime
                                                ? DateFormat("EEE, dd MMM y")
                                                    .format(controller
                                                        .selectedDate!)
                                                : '--',
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (controller.isRegis)
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 8, right: 8, top: 7),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.people_alt,
                                      color: Color(0xff8332A6),
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Gender',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Color(0xff8332A6),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Radio<String>(
                                              value: 'male',
                                              groupValue:
                                                  controller.selectedGender,
                                              onChanged: (value) {
                                                controller.selectedGender =
                                                    value ?? '';
                                              },
                                              activeColor: Color(0xff8332A6),
                                            ),
                                            Text('male'),
                                            Radio<String>(
                                              value: 'female',
                                              groupValue:
                                                  controller.selectedGender,
                                              onChanged: (value) {
                                                controller.selectedGender =
                                                    value ?? '';
                                              },
                                              activeColor: Color(0xff8332A6),
                                            ),
                                            Text('female'),
                                          ],
                                        ),
                                      ],
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
                Padding(
                  padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (controller.isRegis) { 
                          if (controller.isSaving) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      CircularProgressIndicator(
                                          color: Color(0xff8332A6)),
                                      15.height,
                                      Text(
                                        'Loading..',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff8332A6)),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          } else {
                            controller.signup();
                          }
                        } else {
                          if (controller.isSaving) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      CircularProgressIndicator(
                                          color: Color(0xff8332A6)),
                                      15.height,
                                      Center(
                                        child: Text(
                                          'Loading..',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff8332A6)),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          } else {
                            controller.login();
                          }
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 8,
                      shadowColor: Colors.grey,
                      backgroundColor: Color(0xff8332A6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text(
                      controller.isRegis ? 'Sign Up' : 'Sign In',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      controller.isRegis = !controller.isRegis;
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        controller.isRegis
                            ? 'Already have account? Login here'
                            : 'Doesn’t Have Account? Register Here',
                        style: TextStyle(
                            color: Color(0xff8332A6),
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        controller.isRegis ? '' : 'Forgot Password',
                        style: TextStyle(
                            color: Color(0xff8332A6),
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
