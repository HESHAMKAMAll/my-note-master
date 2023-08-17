import 'package:backdrop/backdrop.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_notes/controllers/themes.dart';
import 'package:my_notes/ui/add_edit/edit_note.dart';
import 'package:my_notes/ui/add_edit/view_note.dart';
import 'package:my_notes/ui/home/profile.dart';
import 'package:my_notes/widgets/AppColors.dart';
import 'package:my_notes/ui/add_edit/add_note.dart';
import 'package:my_notes/ui/auth/login_screen.dart';
import 'package:my_notes/widgets/list_note.dart';
import 'package:my_notes/widgets/my_button.dart';
import 'package:my_notes/widgets/my_field.dart';

// import 'package:my_notes/profile.dart';
// import 'package:my_notes/test.dart';

import 'off_line-note.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var notesref = FirebaseFirestore.instance.collection('notes');
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> membersList = []; // لحفظ بيانات المستخدم داخلها

  @override
  void initState() {
    super.initState();
    getCurrentUserDetails();
  }

  void getCurrentUserDetails() async {
    // لعرض اسم المستخدم
    await _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((map) {
      setState(() {
        membersList.add({
          "name": map['name'],
          "email": map['email'],
          "uid": map['uid'],
          // "isAdmin": true,
        });
      });
    });
  }

  bool notify = false; //    تاخذ القيمه من Switch لتعديل الثييم
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // var image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: ListView.builder(
                itemCount: membersList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Text(
                    "${membersList[index]['name']}",
                    style: TextStyle(fontSize: 20),
                  );
                },
              ),
              accountEmail: ListView.builder(
                itemCount: membersList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Text(
                    "${membersList[index]['email']}",
                  );
                },
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "http://meaningnames.net/Diwani/Hisham-Name-in-Arabic-Calligraphy.jpg"),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    "https://media.vanityfair.com/photos/5e8f9f875752fb00088317c4/16:9/w_1280,c_limit/The-Art-of-Making-Art-About-a-Plague.jpg",
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              otherAccountsPictures: [],
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(),
                    ));
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Add A Note"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(),
                    ));
              },
            ),
            ListTile(
              leading: Icon(Icons.add_comment_outlined),
              title: Text("Add A Note Off Line"),
              onTap: () {
                Get.to(OffLineHome());
              },
            ),
            ListTile(
              leading: Icon(Icons.account_box),
              title: Text("About"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.grid_3x3_outlined),
              title: Text("Products"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.contact_mail),
              title: Text("Contact"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile"),
              onTap: () {
                Get.to(Profile());
              },
            ),
            ListTile(
              leading: Icon(Icons.color_lens_outlined),
              title: Row(
                children: [
                  Text("Theme"),
                  Switch(
                    onChanged: (val) {
                      if (Get.isDarkMode) {
                        Get.changeTheme(Themes.customLightTheme);
                      } else {
                        Get.changeTheme(Themes.customDarkTheme);
                      }
                      Future.delayed(Duration(milliseconds: 200), () {
                        setState(() {
                          notify = val;
                        });
                      });
                    },
                    value: notify,
                  ),
                ],
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.output),
              title: Text("Sign Out"),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ));
              },
            ),
          ],
        ),
      ),
      body: BackdropScaffold(
        appBar: BackdropAppBar(
          title: Text(
            "19".tr,
            style: TextStyle(fontFamily: 'Pacifico'),
          ),
          actions: [
            new IconButton(
              icon: new Icon(Icons.settings),
              onPressed: () => _scaffoldKey.currentState!.openDrawer(),
            ),
          ],
        ),
        backLayer: AddNote(),
        subHeader: BackdropSubHeader(
          leading: IconButton(
              onPressed: () {
                Get.to(OffLineHome());
              },
              icon: Icon(
                Icons.cloud_off_outlined,
                color: Get.isDarkMode ? Colors.pink : Colors.black,
              )),
          title: ListView.builder(
            itemCount: membersList.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                children:
                [
                  Text(
                    "20".tr,
                    style: TextStyle(fontFamily: 'Pacifico'),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "${membersList[index]['name']}",
                    style: TextStyle(fontFamily: 'Pacifico'),
                  ),
                ],
              ));
            },
          ),
        ),
        frontLayer: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: notesref
                .where('userid',
                    isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 230,
                    // childAspectRatio: 3,
                  ),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, i) {
                    return Dismissible(
                      onDismissed: (direction) async {
                        await notesref
                            .doc(
                              snapshot.data!.docs[i].id,
                            )
                            .delete(); //لحذف الملاحظه
                        await FirebaseStorage.instance
                            .refFromURL(snapshot.data!.docs[i]['imageurl'])
                            .delete()
                            .then((value) {
                          print('=========================================');
                          print('Delete');
                        }); //احذف الصوره
                      },
                      key: UniqueKey(),
                      child: ListNotes(
                        notes: snapshot.data!.docs[i],
                        docid: snapshot.data!.docs[i].id,
                      ),
                    ); //تستطيع من خلالها عمل اسويب للحذف

                    // return ListNotes(notes: snapshot.data!.docs[i],);
                  },
                );
              }
              return Center(
                  child: Text(
                "Loading...",
                style: TextStyle(fontWeight: FontWeight.bold),
              ));
            },
          ),
        ),
      ),
    );
  }
}

