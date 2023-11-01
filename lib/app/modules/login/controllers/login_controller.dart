  import 'package:firebase_app/app/data/models/user_model.dart';
  import 'package:firebase_app/app/routes/app_pages.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:flutter/material.dart';
  import 'package:get/get.dart';

  class LoginController extends GetxController {
    // var isPasswordHidden = true.obs;

    // void togglePasswordVisibility() {
    //   isPasswordHidden.value = !isPasswordHidden.value;
    // }
    FirebaseAuth auth = FirebaseAuth.instance;

    Stream<User?> get streamAuthStatus => auth.authStateChanges();

    var role = 'user';

    var currUser = UserModel().obs;
    UserModel get user => currUser.value;
    set user(UserModel value) => currUser.value = value;

    var _isRegis = false.obs;
    bool get isRegis => _isRegis.value;
    set isRegis(value) => _isRegis.value = value;

    var _isSaving = false.obs;
    bool get isSaving => _isSaving.value;
    set isSaving(value) => _isSaving.value = value;

    late Rx<User?> firebaseUser; 

    TextEditingController emailC = TextEditingController();
    TextEditingController passC = TextEditingController();

    void login(String email, String password) async {
      try {
        await auth.signInWithEmailAndPassword(email: email, password: password);
        Get.offAndToNamed(Routes.HOME);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user');
        }
      }
    }

    void signup() {}
    void logout() async {
      await FirebaseAuth.instance.signOut();
      Get.offAndToNamed(Routes.LOGIN);
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

    void increment() => count.value++;
  }
