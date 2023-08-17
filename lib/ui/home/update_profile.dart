import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:my_notes/ui/home/profile.dart';

import '../../widgets/my_button.dart';
import '../auth/login_screen.dart';

class UpdateProfile extends StatefulWidget {
  UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  GlobalKey<FormState> formKey = GlobalKey();
  bool isloading = false;
  String? name;
  String? email;
  // final user = FirebaseAuth.instance.currentUser;
  var notesref = FirebaseFirestore.instance.collection('notes');
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  // List<Map<String, dynamic>> membersList = [];
  chang() async {
    if(formKey.currentState!.validate()){
      await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
        'name' : name,
        'email' : email
      });
      setState(() {
        Get.offAll(Profile());
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2B475E),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 600,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(
                    flex: 8,
                  ),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('images/8.png'),
                      const Center(
                        child: Text(
                          'Change',
                          style: TextStyle(
                            fontFamily: 'regular',
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(
                    flex: 8,
                  ),
                  TextFormField(
                    validator: (data) {
                      if (data!.isEmpty) {
                        return 'Field Is Empty';
                      }
                      return null;
                    },
                    onChanged: (val) async{
                      name = val;

                    },
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        label: Text('Name',
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'regular',
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(4))),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  TextFormField(
                    validator: (data) {
                      if (data!.isEmpty) {
                        return 'Field Is Empty';
                      }
                      return null;
                    },
                    onChanged: (val) async{
                      email = val;

                    },
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        label: Text('Email',
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'regular',
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(4))),
                  ),
                  const Spacer(
                    flex: 2,
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
                      await chang();
                    },
                    title: 'Chang',
                    color: Get.isDarkMode
                        ? Colors.pink
                        : Color(0xFFFF6B6B),
                    Width: 140,
                  ),
                  const Spacer(
                    flex: 8,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
