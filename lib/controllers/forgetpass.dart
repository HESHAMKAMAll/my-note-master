import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../ui/auth/login_screen.dart';

TextEditingController Controller = TextEditingController();

forget(context)async{
  await FirebaseAuth.instance
      .sendPasswordResetEmail(
      email: Controller.text)
      .then((value) => {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              LoginScreen(),
        ))
  });
  Get.snackbar(
    '16'.tr,
    '17'.tr,
    colorText: Colors.yellow,
  );
}