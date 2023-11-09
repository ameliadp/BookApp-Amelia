import 'package:firebase_app/app/integrations/firestore.dart';
import 'package:firebase_app/app/data/models/user_model.dart';
import 'package:firebase_app/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class LoginController extends GetxController {
  Rx<DateTime?> _selectedDate = DateTime(2000).obs;
  DateTime? get selectedDate => _selectedDate.value;
  set selectedDate(DateTime? value) => _selectedDate.value = value;

  handleBirthDate(dynamic context) async {
    selectedDate = await showDatePicker(
            context: context,
            initialDate: selectedDate ?? DateTime.now(),
            initialDatePickerMode: DatePickerMode.year,
            firstDate:
                DateTime(selectedDate?.year ?? DateTime.now().year - 100),
            lastDate: DateTime.now()) ??
        selectedDate;
  }

  RxBool isPasswordHidden = true.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  var role = 'user';

  //read data login
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
  String get selectedGender => _selectedGender.value;
  set selectedGender(String value) => _selectedGender.value = value;

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

  login() async {
    try {
      final myUser = await auth.signInWithEmailAndPassword(
          email: emailC.text, password: passC.text);
      if (myUser.user!.emailVerified) {
        Get.offAndToNamed(Routes.HOME);
      } else {
        Get.defaultDialog(
          title: 'Verification',
          titleStyle: TextStyle(color: Color(0xff8332A6)),
          middleText:
              'Verify your email first, Does verification need to be resent?',
          middleTextStyle: TextStyle(color: Color(0xffab59cf)),
          onConfirm: () async {
            await myUser.user!.sendEmailVerification();
            Get.back();
            Get.snackbar(
                'Success', 'Verification code has been sent to your email');
          },
          textConfirm: 'Yes',
          textCancel: 'No',
          buttonColor: Color(0xff8332A6),
          confirmTextColor: Colors.white,
          cancelTextColor: Color(0xff8332A6),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        toast('Tidak ada user untuk email ini');
      } else if (e.code == 'wrong-password') {
        toast('Password salah untuk email ini');
      } else {
        toast(e.toString());
      }
    } catch (e) {
      toast(e.toString());
    }
  }

  // void login(String email, String password) async {
  //   try {
  //     await auth.signInWithEmailAndPassword(
  //         email: emailC.text, password: passC.text);
  //     Get.offAndToNamed(Routes.HOME);
  //   } on FirebaseAuthException catch (e) {
  //     Get.snackbar(e.code, e.message ?? '');
  //   } catch (e) {
  //     Get.snackbar('Error', e.toString());
  //   }
  // }

  void signup() async {
    try {
      isSaving = true;
      UserModel user = UserModel(
        username: nameC.text,
        email: emailC.text,
        password: passC.text,
        birthDate: selectedDate,
        gender: selectedGender,
        image: '',
        time: DateTime.now(),
      );
      UserCredential myUser = await auth.createUserWithEmailAndPassword(
        email: emailC.text,
        password: passC.text,
      );
      await myUser.user!.sendEmailVerification();
      user.id = myUser.user!.uid;
      if (user.id != null) {
        firebaseFirestore
            .collection(usersCollection)
            .doc(user.id)
            .set(user.toJson);
        Get.offAndToNamed(Routes.HOME);
      }
    } on FirebaseAuthException catch (e) {
      isSaving = false;
      if (e.code == 'weak-password') {
        toast('Password terlalu lemah');
      } else if (e.code == 'email-already-in-use') {
        toast('Akun sudah ada untuk email ini');
      } else {
        toast(e.toString());
      }
    }
  }

  // void logout() async {
  //   await FirebaseAuth.instance.signOut();
  //   Get.offAndToNamed(Routes.LOGIN);
  // }

  void logout() async {
    Get.defaultDialog(
      title: 'Logout',
      middleText: 'Anda yakin ingin keluar?',
      onConfirm: () async {
        await FirebaseAuth.instance.signOut();
        Get.back();
        isSaving = false;
        emailC.clear();
        passC.clear();
        Get.offAndToNamed(Routes.LOGIN);
      },
      textConfirm: 'Yes',
      textCancel: 'No',
      buttonColor: Color(0xff8332A6),
      confirmTextColor: Colors.white,
      cancelTextColor: Color(0xff8332A6),
    );
  }

  StreamUser(User? fuser) {
    if (fuser != null) {
      currUser.bindStream(UserModel().streamList(fuser.uid));
      print('auth id = ' + fuser.uid);
    } else {
      print('null auth');
      user = UserModel();
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, StreamUser);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailC.clear();
    passC.clear();
    passC2.clear();
    nameC.clear();
  }
}
