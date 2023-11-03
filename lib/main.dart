import 'package:firebase_app/app/modules/home/views/home_view.dart';
import 'package:firebase_app/app/modules/login/controllers/login_controller.dart';
import 'package:firebase_app/app/modules/login/views/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyDwGCrZ8PEBkiGbWSVjfkUMP-P0Dffs8cM',
          appId: '1:425187107882:android:1844416dbbc51e487d4f53',
          messagingSenderId: '425187107882',
          projectId: 'bookapp-firebase-42764'));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authC = Get.put(LoginController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authC.streamAuthStatus,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          print(snapshot.data);
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Application",
            initialRoute: snapshot.data != null ? Routes.HOME : Routes.LOGIN,
            // AppPages.INITIAL
            // snapshot.data != null ? Routes.HOME : Routes.LOGIN,
            getPages: AppPages.routes,
            // home: snapshot.data != null ? HomeView() : LoginView(),
          );
        } else {
          return Center(
              child: CircularProgressIndicator(
            color: Color(0xff8332A6),
          ));
        }
      },
    );
  }
}
