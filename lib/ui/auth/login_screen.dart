import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:my_notes/controllers/themes.dart';
import 'package:my_notes/ui/auth/forget_password.dart';
import 'package:my_notes/ui/auth/login_admin.dart';
import 'package:my_notes/ui/home/profile.dart';
import 'package:my_notes/widgets/AppColors.dart';
// import 'package:my_notes/forget_password.dart';
import 'package:my_notes/ui/home/home.dart';
import 'package:my_notes/main.dart';
import 'package:my_notes/widgets/my_button.dart';
import 'package:my_notes/widgets/my_field.dart';
// import 'package:my_notes/profile.dart';
import 'package:my_notes/ui/auth/registration_screen.dart';
import '../home/off_line-note.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscureText = true;
  bool isAdmin = false;
  String id = 'LoginScreen';
  late String email;
  late String password;
  final adminPassword = 'admin1234';
  bool isloading = false;
  signIn(context) async {
    var formdata = globalKey.currentState;
    if (formdata!.validate()) {
      try {
        try {
          setState(() {
            isloading = true;
          });
          final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
           if (user != null) {
            setState(() {
              isloading = false;
            });
            Get.to(Home());
          } else {
            setState(() {
              isloading = false;
            });
            Fluttertoast.showToast(msg: "Something is wrong");
          }
        } on FirebaseAuthException catch (e) {
          setState(() {
            isloading = false;
          });
          if (e.code == 'user-not-found') {
            setState(() {
              isloading = false;
            });
            Fluttertoast.showToast(msg: "No user found for that email.");
          } else if (e.code == 'wrong-password') {
            setState(() {
              isloading = false;
            });
            Fluttertoast.showToast(
                msg: "Wrong password provided for that user.");
          }
        }
      } catch (e) {
        print(e);
      }
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 230,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Image.asset('images/5.png'),
                  Text(
                    "1".tr,
                    style: TextStyle(fontSize: 40, color: Colors.white,fontFamily: 'Pacifico'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Get.isDarkMode ? Colors.white12 : Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),
                child: ListView(physics: BouncingScrollPhysics(), children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Form(
                      key: globalKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              if (Get.isDarkMode) {
                                Get.changeTheme(Themes.customLightTheme);
                              } else {
                                Get.changeTheme(Themes.customDarkTheme);
                              }
                              Future.delayed(Duration(milliseconds: 200),(){setState(() {});});
                            },
                            iconSize: 70,
                            icon: Get.isDarkMode
                                ? Icon(Icons.nightlight_rounded,
                                    color: Colors.white, size: 50)
                                : Icon(
                                    Icons.sunny,
                                    color: Colors.yellow,
                                    size: 50,
                                  ),
                          ),
                          Text(
                            "2".tr,
                            style: TextStyle(
                              fontSize: 22,
                                fontFamily: 'Pacifico',
                              color: Get.isDarkMode
                                  ? Colors.pink
                                  : Color(0xFFFF6B6B),
                            ),
                          ),
                          Text(
                            "3".tr,
                            style: TextStyle(
                              fontFamily: 'Pacifico',
                              fontSize: 14,
                              color: Color(0xFFBBBBBB),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            children: [
                              Material(
                                borderRadius: BorderRadius.circular(12),
                                elevation: 30,
                                child: Container(
                                  height: 48,
                                  width: 41,
                                  decoration: BoxDecoration(
                                      color: Get.isDarkMode
                                          ? Colors.pink
                                          : Color(0xFFFF6B6B),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Center(
                                    child: Icon(
                                      Icons.email_outlined,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: MyField2(
                                  controller: emailController,
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  hintText: "Hesham@gmail.com",
                                  validator: (val) {
                                    if (val!.length < 2) {
                                      return "13".tr;
                                    }
                                    return null;
                                  },
                                  labelText: '4'.tr,
                                  obscureText: false,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Material(
                                borderRadius: BorderRadius.circular(12),
                                elevation: 30,
                                child: Container(
                                  height: 48,
                                  width: 41,
                                  decoration: BoxDecoration(
                                      color: Get.isDarkMode
                                          ? Colors.pink
                                          : Color(0xFFFF6B6B),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Center(
                                    child: Icon(
                                      Icons.lock_outline,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: MyField2(
                                  controller: passwordController,
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  hintText: "5".tr,
                                  validator: (val) {
                                    if (val!.length < 2) {
                                      return "13".tr;
                                    }
                                    return null;
                                  },
                                  labelText: '6'.tr,
                                  obscureText: obscureText,
                                  suffixIcon: obscureText == true
                                      ? IconButton(
                                          onPressed: () {
                                            setState(() {
                                              obscureText = false;
                                            });
                                          },
                                          icon: Icon(
                                            Icons.remove_red_eye,
                                            size: 20,
                                          ))
                                      : IconButton(
                                          onPressed: () {
                                            setState(() {
                                              obscureText = true;
                                            });
                                          },
                                          icon: Icon(
                                            Icons.visibility_off,
                                            size: 20,
                                          )),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 70,
                          ),
                          isloading ? MaterialButton(
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(17),
                              borderSide: BorderSide(color: Colors.pink),
                            ),
                            onPressed: (){},
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                            color: Get.isDarkMode
                                ? Colors.pink
                                : Color(0xFFFF6B6B),
                            elevation: 30,
                            minWidth: 140,
                            height: 60,
                          ) :
                          MyButton(
                            onPressed: () async {
                              await signIn(context);
                            },
                            title:  '1'.tr,
                            color: Get.isDarkMode
                                ? Colors.pink
                                : Color(0xFFFF6B6B),
                            Width: 140,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ForgetPassword(),
                                      ));
                                },
                                child: Text(
                                  '9'.tr,
                                  style: TextStyle(
                                    fontFamily: 'Pacifico',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Get.isDarkMode
                                        ? Colors.pink
                                        : Color(0xFFFF6B6B),
                                  ),
                                ),
                              ),
                              Spacer(
                                flex: 1,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginAdmin(),
                                      ));
                                },
                                child: Text(
                                  'I AM AN ADMIN.',
                                  style: TextStyle(
                                    fontFamily: 'Pacifico',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Get.isDarkMode
                                        ? Colors.pink
                                        : Color(0xFFFF6B6B),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          RegistrationScreen()));
                            },
                            child: Container(
                              height: 50,
                              child: Row(
                                children: [
                                  Text(
                                    "7".tr,
                                    style: TextStyle(
                                      fontFamily: 'Pacifico',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFFBBBBBB),
                                    ),
                                  ),
                                  Text(
                                    "8".tr,
                                    style: TextStyle(
                                      fontFamily: 'Pacifico',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Get.isDarkMode
                                          ? Colors.pink
                                          : Color(0xFFFF6B6B),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
