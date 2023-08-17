import 'dart:io';
import 'dart:math';
import 'package:get/get.dart';
import 'package:path/path.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_notes/ui/home/home.dart';
import 'package:my_notes/widgets/my_button.dart';
import 'package:my_notes/widgets/my_field.dart';

class AddNote extends StatefulWidget {
  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  var title, note, imageurl;

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  var noteref = FirebaseFirestore.instance.collection('notes');

  late Reference ref;

  late File file;
  bool isloading = false;

  addNotes() async {
    if (file == null) {
      return Get.snackbar(
        'Choose a photo',
        'Thank you',
        colorText: Colors.yellow,
        duration: Duration(
          seconds: 5,
        ),
      );
    }

    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      setState(() {
        isloading = true;
      });
      formdata.save();

      await ref.putFile(file);
      imageurl = await ref.getDownloadURL();

      await noteref.add({
        'title': title,
        'note': note,
        'imageurl': imageurl,
        'userid': FirebaseAuth.instance.currentUser!.uid
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Get.isDarkMode ? Colors.white10 : Color(0xFFFF6B6B),
      child: ListView(physics: BouncingScrollPhysics(), children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formstate,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyField(
                  onSaved: (val) {
                    title = val;
                  },
                  validator: (val) {
                    if (val!.length < 1) {
                      return 'لا تدع العنوان فارغا';
                    }
                  },
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  hintText: '21'.tr,
                ),
                SizedBox(
                  height: 20,
                ),
                MyField(
                  onSaved: (val) {
                    note = val;
                  },
                  validator: (val) {
                    if (val!.length < 1) {
                      return 'اكتب هنا ملاحظاتك';
                    }
                  },
                  maxLines: 6,
                  textAlign: TextAlign.center,
                  hintText: '22'.tr,
                ),
                SizedBox(
                  height: 30,
                ),
                IconButton(
                    iconSize: 70,
                    onPressed: () {
                      Get.snackbar(
                        '',
                        '',
                        titleText: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                var picked = await ImagePicker()
                                    .pickImage(source: ImageSource.camera);

                                if (picked != null) {
                                  file = File(picked.path);
                                  var rand = Random().nextInt(100000);

                                  var imagename =
                                      "$rand" + auth.basename(picked.path);

                                  ref = FirebaseStorage.instance
                                      .ref('images')
                                      .child('$imagename');
                                  // Navigator.pop(context);
                                }
                              },
                              child: Column(
                                children: [
                                  Text('23'.tr,
                                      style: TextStyle(
                                          color: Get.isDarkMode
                                              ? Colors.pink
                                              : Colors.black)),
                                  Icon(Icons.camera_alt,
                                      size: 40,
                                      color: Get.isDarkMode
                                          ? Colors.pink
                                          : Colors.black),
                                ],
                              ),
                            ),
                            SizedBox(width: 60),
                            InkWell(
                              onTap: () async {
                                var picked = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);

                                if (picked != null) {
                                  file = File(picked.path);
                                  var rand = Random().nextInt(100000);

                                  var imagename =
                                      "$rand" + auth.basename(picked.path);

                                  ref = FirebaseStorage.instance
                                      .ref('images')
                                      .child('$imagename');

                                  // Navigator.pop(context);

                                }
                              },
                              child: Column(
                                children: [
                                  Text('24'.tr,
                                      style: TextStyle(
                                          color: Get.isDarkMode
                                              ? Colors.pink
                                              : Colors.black)),
                                  Icon(Icons.photo,
                                      size: 40,
                                      color: Get.isDarkMode
                                          ? Colors.pink
                                          : Colors.black),
                                ],
                              ),
                            ),
                          ],
                        ),
                        snackPosition: SnackPosition.BOTTOM,
                        duration: Duration(
                          seconds: 10,
                        ),
                      );
                    },
                    icon: Icon(Icons.photo,
                        size: 70,
                        color: Get.isDarkMode ? Colors.pink : Colors.black)),
                SizedBox(
                  height: 30,
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
                      var formdata = formstate.currentState;
                      if(formdata!.validate()){
                        if (file == null) {
                          return ;
                        }
                        Get.snackbar(
                          'Wait patiently',
                          'Thank you',
                          colorText: Colors.yellow,
                          duration: Duration(
                            seconds: 5,
                          ),
                        );
                        await addNotes();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(),
                            ));
                      }
                    },
                    title: '25'.tr,
                    color: Get.isDarkMode ? Colors.pink : Colors.black,
                    Width: 140),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
