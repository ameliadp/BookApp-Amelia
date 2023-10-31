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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Image.asset(
                  'assets/images/iconLogin.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
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
                  margin:
                      EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 8, right: 8, top: 8),
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
                                controller: controller.emailC,
                                autocorrect: false,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  labelStyle:
                                      TextStyle(color: Color(0xff8332A6)),
                                  border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff8332A6)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff8332A6)),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff8332A6)),
                                  ),
                                ),
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
                            Icon(Icons.lock_outline, color: Color(0xff8332A6)),
                            SizedBox(width: 10),
                            SizedBox(
                              height: 60,
                              width: 220,
                              child: TextFormField(
                                autocorrect: false,
                                controller: controller.passC,
                                // obscureText: controller.isPasswordHidden.value,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle:
                                      TextStyle(color: Color(0xff8332A6)),
                                  // suffixIcon: IconButton(
                                  //   onPressed: () {
                                  //     controller.togglePasswordVisibility(); 
                                  //   },
                                  //   icon: Icon(
                                  //     controller.isPasswordHidden.value
                                  //         ? Icons.visibility_off
                                  //         : Icons.visibility,
                                  //     color: Color(0xff8332A6),
                                  //   ),
                                  // ),
                                  border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff8332A6)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff8332A6)),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff8332A6)),
                                  ),
                                ),
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
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
              child: ElevatedButton(
                onPressed: () {
                  controller.login(
                      controller.emailC.text, controller.passC.text);
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
                  'Sign In',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    'Doesn’t Have Account? Register Here',
                    style: TextStyle(
                        color: Color(0xff8332A6), fontStyle: FontStyle.italic),
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
                    'Forgot Password',
                    style: TextStyle(
                        color: Color(0xff8332A6), fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
