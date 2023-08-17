import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_notes/controllers/forgetpass.dart';
import 'package:my_notes/ui/auth/login_screen.dart';
import 'package:my_notes/widgets/my_button.dart';
import 'package:my_notes/widgets/my_field.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children:
          [
            SizedBox(
              height: 220,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Image.asset('images/8.png'),
                  Text(
                    "14".tr,
                    style: TextStyle(fontSize: 30, color: Colors.white,fontFamily: 'Pacifico'),
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
                child: ListView(
                    physics: BouncingScrollPhysics(),
                    children:
                    [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                        [
                          SizedBox(
                            height: 30,
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
                                  controller: Controller,
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
                            height: 50,
                          ),
                          MyButton(
                            onPressed: () async {
                              forget(context);
                            },
                            title: '15'.tr,
                            color: Get.isDarkMode
                                ? Colors.pink
                                : Color(0xFFFF6B6B),
                            Width: 140,
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
