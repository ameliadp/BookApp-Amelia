import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFBF2FF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 40),
            ),
            Center(
              child: Image.asset(
                'assets/images/iconLogin.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Card(
              elevation: 7,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
              ),
            )
          ],
        ),
      ),
    );
  }
}
