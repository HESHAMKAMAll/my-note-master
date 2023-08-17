import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_notes/ui/add_edit/edit_note.dart';

class Iamge extends StatelessWidget {
  final notes;
  Iamge({Key? key, this.notes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? Colors.white24 : Colors.white,
      body: Center(
          child: Material(
            color: Get.isDarkMode ? Colors.white12:Colors.white60,
            borderRadius: BorderRadius.circular(17),
            elevation: 30,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(17.0),
              child: Image.network(
                "${notes['imageurl']}",
                fit: BoxFit.cover,
              ),
            ),
          )),
    );
  }
}