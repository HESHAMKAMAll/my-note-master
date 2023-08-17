import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_notes/ui/add_edit/edit_note.dart';
import 'package:my_notes/ui/add_edit/view_image.dart';

class ViewNote extends StatelessWidget {
  final notes;
  ViewNote({Key? key, this.notes }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? Colors.white24 : Colors.white,
      appBar: AppBar(
        title: Text('View Notes'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Material(
              color: Get.isDarkMode ? Colors.white12:Colors.white60,
              borderRadius: BorderRadius.circular(25),
              elevation: 30,
              child: Column(
                children:
                [
                  Container(
                      child: InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                            return Iamge(notes: notes);
                          }));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
                          child: Image.network(
                            "${notes['imageurl']}",
                            width: double.infinity,
                            height: 500,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        "${notes['title']}",
                        style: Theme.of(context).textTheme.headline5,
                      )),
                  Divider(),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        "${notes['note']}",
                        style: Theme.of(context).textTheme.bodyText2,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}