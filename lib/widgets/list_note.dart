import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:my_notes/ui/add_edit/edit_note.dart';
import 'package:my_notes/ui/add_edit/view_note.dart';

class ListNotes extends StatelessWidget {
  final notes;
  final docid;

  ListNotes({this.notes, this.docid});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ViewNote(notes: notes);
        }));
      },
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.network(
                  "${notes['imageurl']}",
                  height: 130,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Expanded(
            //   flex: 1,
            //   child: Column(
            //     children:
            //     [
            //       Row(
            //         children:
            //         [
            //           Column(
            //             children:
            //             [
            //               Text("${notes['title']}",maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
            //               Text(
            //                   "${notes['note']}",
            //                   maxLines: 2,
            //                   style: TextStyle(color: Get.isDarkMode ? Colors.white54 : Colors.black54,)),
            //             ],
            //           ),
            //           IconButton(
            //             onPressed: () {
            //               Navigator.of(context).push(MaterialPageRoute(builder: (context){
            //                 return EditNotes(docid: docid,list: notes,);
            //               }));
            //             },
            //             icon: Icon(
            //               Icons.edit,
            //               color: Theme.of(context).primaryColor,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ],
            //   )
            // ),
            ListTile(
              title: Text("${notes['title']}",maxLines: 1),
              subtitle: Text("${notes['note']}",maxLines: 1,style: TextStyle(fontSize: 10)),
              trailing: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return EditNotes(docid: docid,list: notes,);
                  }));
                },
                icon: Icon(
                  Icons.edit,
                  color: Get.isDarkMode ? Colors.pink : Color(0xFFFF6B6B),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}