import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:my_notes/controllers/locale.dart';
import 'package:my_notes/controllers/themes.dart';
import 'package:my_notes/ui/home/home.dart';
import 'package:my_notes/ui/auth/login_screen.dart';

late bool isLogin ;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var user = FirebaseAuth.instance.currentUser ;
  if(user == null){
    isLogin = false ;
  }else{
    isLogin = true ;
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Get.deviceLocale,
      translations: MyLocale(),
      theme: Themes.customLightTheme,
      // theme: darkMode ? _darkTheme: _lightTheme,
      home: isLogin == false ? LoginScreen() : Home(),
    );
  }
}
