import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<User?> createAccount(String name, String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    UserCredential userCrendetial = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    print("Account created Succesfull");

    userCrendetial.user!.updateDisplayName(name);

    await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
      "name": name,
      "email": email,
      "status": "Unavalible",
      "uid": _auth.currentUser!.uid,
    });

    return userCrendetial.user;
  } catch (e) {
    print(e);
    return null;
  }
}



// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import '../ui/home/home.dart';
//
// final GlobalKey<FormState> globalKey2 = GlobalKey<FormState>();
// TextEditingController emailController2 = TextEditingController();
// TextEditingController passwordController2 = TextEditingController();
// bool obscureText2 = true;
//
// signUp() async {
//   var formdata = globalKey2.currentState;
//   if (formdata!.validate()) {
//     try {
//       UserCredential userCredential = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(
//           email: emailController2.text,
//           password: passwordController2.text);
//       var authCredential = userCredential.user;
//       print(authCredential!.uid);
//       if (authCredential.uid.isNotEmpty) {
//         Get.to(Home());
//       } else {
//         Fluttertoast.showToast(msg: "Something is wrong");
//       }
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         Fluttertoast.showToast(msg: "The password provided is too weak.");
//       } else if (e.code == 'email-already-in-use') {
//         Fluttertoast.showToast(
//             msg: "The account already exists for that email.");
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
// }