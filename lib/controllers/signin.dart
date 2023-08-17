
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:my_notes/ui/home/home.dart';
// import 'package:my_notes/ui/home/profile.dart';

// final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
// TextEditingController emailController = TextEditingController();
// TextEditingController passwordController = TextEditingController();
//
// bool obscureText = true;
// bool isAdmin = false;
//
//  String id = 'LoginScreen';
//
// late String email;
// late String password;
//
// final adminPassword = 'admin1234';
//
// signIn(context) async {
//   var formdata = globalKey.currentState;
//   if (formdata!.validate()) {
//
//     try {
//       try {
//         final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
//             email: emailController.text, password: passwordController.text);
//         if (passwordController == adminPassword) {
//           Navigator.push(
//               context, CupertinoPageRoute(builder: (_) => Profile()));
//         } else if (user != null) {
//           Get.to(Home());
//         } else {
//           Fluttertoast.showToast(msg: "Something is wrong");
//         }
//       } on FirebaseAuthException catch (e) {
//         if (e.code == 'user-not-found') {
//           Fluttertoast.showToast(msg: "No user found for that email.");
//         } else if (e.code == 'wrong-password') {
//           Fluttertoast.showToast(
//               msg: "Wrong password provided for that user.");
//         }
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
// }