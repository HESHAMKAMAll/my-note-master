import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_notes/ui/home/home.dart';
import 'package:my_notes/widgets/my_field.dart';
import 'package:path/path.dart' as auth ;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditNotes extends StatefulWidget {

  final docid ;
  final list ;

  const EditNotes({Key? key, this.docid, this.list}) : super(key: key);

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {

  var notesref = FirebaseFirestore.instance.collection('notes') ;

  late Reference ref ;

  late File file ;

  var title , note , imageurl ;



  GlobalKey<FormState> formstate = new GlobalKey<FormState>() ;

  EditNotes() async {
    var formdata = formstate.currentState ;
    if (file == null) {
      if (formdata!.validate()){
        formdata.save() ;

        await notesref.doc(widget.docid).update({
          'title' : title ,
          'note' : note ,
        });
      }
    }else {
      if (formdata!.validate()){
        formdata.save() ;

        await ref.putFile(file);
        imageurl =  await ref.getDownloadURL();

        await notesref.doc(widget.docid).update({
          'title' : title ,
          'note' : note ,
          'imageurl' : imageurl ,
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Notes"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children:
            [
              Form(
                key: formstate,
                child: Column(
                  children:
                  [
                    SizedBox(
                      height: 50,
                    ),
                    Material(
                      color: Get.isDarkMode ? Colors.white12:Colors.white60,
                      borderRadius: BorderRadius.circular(17),
                      elevation: 30,
                      child: TextFormField(
                        onSaved: (val){
                          title = val ;
                        },
                        validator: (val){
                          if (val!.length < 1){
                            return 'لا يجب ان يكون العنوان فارغ' ;
                          }
                        },
                        initialValue: widget.list['title'],
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: "Title Note",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(17),
                              borderSide: const BorderSide(color: Colors.black38)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(17),
                              borderSide: const BorderSide(color: Colors.white12)),
                        ),
                      ),
                    ),
                    // TextFormField(
                    //   validator: (val){
                    //     if (val!.length < 1){
                    //       return 'لا يجب ان يكون العنوان فارغ' ;
                    //     }
                    //   },
                    //   initialValue: widget.list['title'],
                    //   onSaved: (val){
                    //     title = val ;
                    //   },
                    //   maxLength: 30,
                    //   decoration: InputDecoration(
                    //     filled: true,
                    //     fillColor: Colors.white,
                    //     labelText: "Title Note",
                    //     prefixIcon: Icon(
                    //       Icons.note,
                    //       color: Theme.of(context).primaryColor,
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Material(
                      color: Get.isDarkMode ? Colors.white12:Colors.white60,
                      borderRadius: BorderRadius.circular(17),
                      elevation: 30,
                      child: TextFormField(
                        onSaved: (val){
                          note = val ;
                        },
                        validator: (val){
                          if (val!.length < 1){
                            return 'لا يجب ان يكون العنوان فارغ' ;
                          }
                        },
                        initialValue: widget.list['note'],
                        minLines: 1,
                        maxLines: 4,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: "Note",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(17),
                              borderSide: const BorderSide(color: Colors.black38)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(17),
                              borderSide: const BorderSide(color: Colors.white12)),
                        ),
                      ),
                    ),
                    // TextFormField(
                    //   validator: (val){
                    //     if (val!.length < 1){
                    //       return 'لا يجب ان يكون فارغ' ;
                    //     }
                    //   },
                    //   initialValue: widget.list['note'],
                    //   onSaved: (val){
                    //     note = val ;
                    //   },
                    //   minLines: 1,
                    //   maxLines: 4,
                    //   maxLength: 300,
                    //   decoration: InputDecoration(
                    //     filled: true,
                    //     fillColor: Colors.white,
                    //     labelText: "Note",
                    //     prefixIcon: Icon(
                    //       Icons.note,
                    //       color: Theme.of(context).primaryColor,
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 90,
                    ),
                    MaterialButton(
                      onPressed: (){
                        showBottomSheet(context);
                      },
                      child: Text("Edit Image For Note"),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        await EditNotes();
                        Get.to(()=>Home());
                      },
                      child: Text("Edit Note",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      )),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      padding: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  showBottomSheet(context){
    return showModalBottomSheet(
      context: context,
      builder: (context){
        return Container(
          padding: EdgeInsets.all(20),
          height: 170,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              Text(
                  "Edit Image",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  )),
              InkWell(
                onTap: () async {
                  var picked = await ImagePicker().pickImage(source: ImageSource.gallery);

                  if (picked != null ){
                    file = File(picked.path) ;
                    var rand = Random().nextInt(100000);

                    var imagename =  "$rand" + auth.basename(picked.path);

                    ref = FirebaseStorage.instance.ref('images').child('$imagename');

                    Navigator.pop(context);

                  }

                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children:
                    [
                      Icon(
                        Icons.photo,
                        color: Theme.of(context).primaryColor,
                      ),
                      Text(
                        "From Gallery",
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  var picked = await ImagePicker().pickImage(source: ImageSource.camera);

                  if (picked != null ){
                    file = File(picked.path) ;
                    var rand = Random().nextInt(100000);

                    var imagename =  "$rand" + auth.basename(picked.path);

                    ref = FirebaseStorage.instance.ref('images').child('$imagename');

                    Navigator.pop(context);

                  }

                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children:
                    [
                      Icon(Icons.camera_alt,
                        color: Theme.of(context).primaryColor,
                      ),
                      Text(
                        "From Camera",
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}



