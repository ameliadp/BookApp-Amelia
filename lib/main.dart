import 'package:firebase_app/app/controllers/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: '',
          appId: '1:425187107882:android:1844416dbbc51e487d4f53',
          messagingSenderId: '425187107882',
          projectId: 'bookapp-firebase-42764'));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authC = Get.put(AuthController(), permanent: true);

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
            initialRoute: AppPages.INITIAL,
            // snapshot.data != null ? Routes.HOME : Routes.LOGIN,
            getPages: AppPages.routes,
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
