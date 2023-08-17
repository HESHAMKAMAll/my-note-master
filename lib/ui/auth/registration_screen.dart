// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:my_notes/controllers/signup.dart';
import 'package:my_notes/controllers/themes.dart';
import 'package:my_notes/widgets/AppColors.dart';
import 'package:my_notes/ui/home/home.dart';
import 'package:my_notes/ui/auth/login_screen.dart';
import 'package:my_notes/widgets/my_button.dart';
import 'package:my_notes/widgets/my_field.dart';

// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shop_e_commerce/const/AppColors.dart';
// import 'package:shop_e_commerce/ui/addnotes.dart';
// import 'package:shop_e_commerce/ui/login_screen.dart';
// import 'package:shop_e_commerce/ui/user_form.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> globalKey2 = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool obscureText2 = true;
  bool isloading = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 230,
              child: Column(
                children:
                [
                  SizedBox(
                    height: 30,
                  ),
                  Image.asset('images/4.png'),
                  Text(
                    "8".tr,
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
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Form(
                        key: globalKey2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                          [
                            IconButton(
                              onPressed: (){
                                if(Get.isDarkMode){
                                  Get.changeTheme(Themes.customLightTheme);
                                }else{
                                  Get.changeTheme(Themes.customDarkTheme);
                                }
                              },
                              iconSize: 70,
                              icon: Get.isDarkMode? Icon(Icons.nightlight_rounded, color:Colors.white,size: 50): Icon(Icons.sunny, color:Colors.yellow,size: 50,),
                            ),
                            Text(
                              "10".tr,
                              style: TextStyle(
                                fontFamily: 'Pacifico',
                                fontSize: 22,
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
                                        borderRadius:
                                        BorderRadius.circular(12)),
                                    child: Center(
                                      child: Icon(
                                        Icons.person,
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
                                    controller: _name,
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
                                    hintText: "هشام",
                                    validator: (val) {
                                      if (val!.length < 2) {
                                        return "13".tr;
                                      }
                                      return null;
                                    },
                                    labelText: '18'.tr,
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
                                        borderRadius:
                                            BorderRadius.circular(12)),
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
                                    controller: _email,
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
                                        borderRadius:
                                            BorderRadius.circular(12)),
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
                                    controller: _password,
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
                                    obscureText: obscureText2,
                                    suffixIcon: obscureText2 == true
                                        ? IconButton(
                                            onPressed: () {
                                              setState(() {
                                                obscureText2 = false;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.remove_red_eye,
                                              size: 20,
                                            ))
                                        : IconButton(
                                            onPressed: () {
                                              setState(() {
                                                obscureText2 = true;
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
                                var formdata = globalKey2.currentState;
                                if (formdata!.validate()) {
                                  setState(() {
                                    isloading = true;
                                  });
                                  createAccount(_name.text, _email.text, _password.text).then((user) {
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
                                  });
                                }else {
                                  setState(() {
                                    isloading = false;
                                  });
                                  print("Please enter Fields");
                                }
                              },
                              title: '11'.tr,
                              color: Get.isDarkMode
                                  ? Colors.pink
                                  : Color(0xFFFF6B6B),
                              Width: 140,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => LoginScreen()));
                              },
                              child: Container(
                                height: 50,
                                child: Row(
                                  children: [
                                    Text(
                                      "12".tr,
                                      style: TextStyle(
                                        fontFamily: 'Pacifico',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFFBBBBBB),
                                      ),
                                    ),
                                    Text(
                                      "1".tr,
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
