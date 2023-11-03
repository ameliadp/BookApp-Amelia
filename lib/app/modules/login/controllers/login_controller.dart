import 'package:firebase_app/app/addition/firestore.dart';
import 'package:firebase_app/app/data/models/user_model.dart';
import 'package:firebase_app/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool isPasswordHidden = true.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }
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

  RxString _selectedGender = ''.obs;
  RxString get selectedGender => _selectedGender;

  void setSelectedGender(String value) {
    _selectedGender = value.obs;
    update();
  }

  late Rx<User?> firebaseUser;

  TextEditingController nameC = TextEditingController();
  TextEditingController passC = TextEditingController();
  TextEditingController passC2 = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController birthDateC = TextEditingController();

  void login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: emailC.text, password: passC.text);
      Get.offAndToNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      Get.snackbar(e.code, e.message ?? '');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void signup() async {
    try {
      isSaving = true;
      UserModel user = UserModel(
        username: nameC.text,
        email: emailC.text,
        birthDate: DateTime.now(),
        time: DateTime.now(),
      );
      UserCredential myUser = await auth.createUserWithEmailAndPassword(
        email: emailC.text,
        password: passC.text,
      );
      await myUser.user!.sendEmailVerification();
      user.id = myUser.user!.uid;
      if (user.id != null) {
        firebaseFirestore.collection(usersCollection).doc(user.id).set(user.toJson).then((value) {
          Get.defaultDialog(title: 'Verifikasi Email', middleText: 'Kami telah mengirimkan verifikasi ke Email anda', textConfirm: 'Oke', onConfirm: () {});
        });
      }
    }
  }
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
