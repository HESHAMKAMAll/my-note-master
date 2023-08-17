import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_notes/ui/home/update_profile.dart';

import '../../widgets/my_button.dart';
import '../auth/forget_password.dart';
import '../auth/login_screen.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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

  del()async{
    await FirebaseAuth.instance.currentUser!.delete();
  }

  bool notify = false; //    تاخذ القيمه من Switch لتعديل الثييم
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFF2B475E),
      body: ListView(
        children: [
          Container(
            height: 620.0,
            decoration: new BoxDecoration(
              color: Get.isDarkMode
                  ? Colors.pink
                  : Color(0xFFFF6B6B),
              boxShadow: [
                new BoxShadow(blurRadius: 40.0)
              ],
              borderRadius: new BorderRadius.vertical(
                  bottom: new Radius.elliptical(
                      MediaQuery.of(context).size.width, 100.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Spacer(flex: 1),
                  ListView.builder(
                    itemCount: membersList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Text(
                        "   Hi ${membersList[index]['name']}",
                        style: TextStyle(fontSize: 20,fontFamily: 'Pacifico'),
                      );
                    },
                  ),
                  CircleAvatar(
                    radius: 103,
                    backgroundColor: Colors.amber,
                    child: CircleAvatar(
                      backgroundColor: Color(0xff303030),
                      radius: 100,
                      backgroundImage: AssetImage('images/11.png'),
                    ),
                  ),
                  Text(
                    'Hehsam Kamal',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'Pacifico',
                    ),
                  ),
                  Text(
                    'FLUTTER DEVELOPER',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      // fontFamily: 'Pacifico',
                    ),
                  ),
                  Divider(
                    color: Colors.white70,
                    thickness: 0.2,
                    indent: 40,
                    endIndent: 40,
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.person,
                        color: Get.isDarkMode
                          ? Colors.pink
                          : Color(0xFFFF6B6B),
                        size: 37,
                      ),
                      title: ListView.builder(
                        itemCount: membersList.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Text(
                            "\n${membersList[index]['name']}\n",
                            style: TextStyle(fontSize: 20),
                          );
                        },
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.email,
                        color: Get.isDarkMode
                          ? Colors.pink
                          : Color(0xFFFF6B6B),
                        size: 35,
                      ),
                      title: ListView.builder(
                        itemCount: membersList.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Text(
                            "\n${membersList[index]['email']}\n",
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        MaterialButton(
                          onPressed: () async {
                            Get.offAll(() => ForgetPassword());
                          },
                          child: Text('15'.tr),
                          color: Get.isDarkMode ? Color(0xFF24303B) : Color(0xFFFF6B6B),
                        ),
                        Spacer(flex: 1),
                        MaterialButton(
                          onPressed: () async {
                            Get.to(() => UpdateProfile());
                          },
                          child: Text('26'.tr),
                          color: Get.isDarkMode ? Color(0xFF24303B) : Color(0xFFFF6B6B),
                        ),
                      ],
                    ),
                  ),
                  Spacer(flex: 2),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  children: [
                    Text('27'.tr),
                    IconButton(
                      onPressed: () async{
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ));
                      },
                      icon: Icon(Icons.exit_to_app),
                    ),
                  ],
                ),
              ),
              Spacer(
                flex: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Text('28'.tr),
                    IconButton(
                      onPressed: () async{
                        del();
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ));
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Container(
          //   height: 800.0,
          //   color: Get.isDarkMode ? Colors.white10 : Color(0xFFFF6B6B),
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 10),
          //     child: Column(
          //       children: [
          //         Spacer(flex: 1),
          //         ListView.builder(
          //           itemCount: membersList.length,
          //           shrinkWrap: true,
          //           physics: NeverScrollableScrollPhysics(),
          //           itemBuilder: (context, index) {
          //             return Text(
          //               "Hi ${membersList[index]['name']}",
          //               style: TextStyle(fontSize: 20),
          //             );
          //           },
          //         ),
          //         CircleAvatar(
          //           radius: 102,
          //           backgroundColor: Colors.amber,
          //           child: CircleAvatar(
          //             radius: 100,
          //             backgroundImage: AssetImage('images/7.png'),
          //           ),
          //         ),
          //         Text(
          //           'Hehsam Kamal',
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 25,
          //             fontFamily: 'Pacifico',
          //           ),
          //         ),
          //         Text(
          //           'FLUTTER DEVELOPER',
          //           style: TextStyle(
          //             color: Colors.grey,
          //             fontSize: 12,
          //             // fontFamily: 'Pacifico',
          //           ),
          //         ),
          //         Divider(
          //           color: Colors.white70,
          //           thickness: 0.2,
          //           indent: 40,
          //           endIndent: 40,
          //         ),
          //         Card(
          //           child: ListTile(
          //             leading: Icon(Icons.person, color: Color(0xFF2B475E)),
          //             title: ListView.builder(
          //               itemCount: membersList.length,
          //               shrinkWrap: true,
          //               physics: NeverScrollableScrollPhysics(),
          //               itemBuilder: (context, index) {
          //                 return Text(
          //                   "${membersList[index]['name']}\n",
          //                   style: TextStyle(fontSize: 20),
          //                 );
          //               },
          //             ),
          //           ),
          //         ),
          //         Card(
          //           child: ListTile(
          //             leading: Icon(Icons.email, color: Color(0xFF2B475E)),
          //             title: ListView.builder(
          //               itemCount: membersList.length,
          //               shrinkWrap: true,
          //               physics: NeverScrollableScrollPhysics(),
          //               itemBuilder: (context, index) {
          //                 return Text(
          //                   "${membersList[index]['email']}\n",
          //                 );
          //               },
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.all(4.0),
          //           child: Row(
          //             children: [
          //               MaterialButton(
          //                 onPressed: () async {
          //                   Get.offAll(() => ForgetPassword());
          //                 },
          //                 child: Text('15'.tr),
          //                 color: Get.isDarkMode ? Color(0xFF24303B) : Color(0xFFFF6B6B),
          //               ),
          //               Spacer(flex: 1),
          //               MaterialButton(
          //                 onPressed: () async {
          //                   Get.to(() => UpdateProfile());
          //                 },
          //                 child: Text('Chang Name and Email'),
          //                 color: Get.isDarkMode ? Color(0xFF24303B) : Color(0xFFFF6B6B),
          //               ),
          //             ],
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.all(4.0),
          //           child: Row(
          //             children: [
          //               Text('Sign Out'),
          //               IconButton(
          //                 onPressed: () async{
          //                   await FirebaseAuth.instance.signOut();
          //                   Navigator.pushReplacement(
          //                       context,
          //                       MaterialPageRoute(
          //                         builder: (context) => LoginScreen(),
          //                       ));
          //                 },
          //                 icon: Icon(Icons.exit_to_app),
          //               ),
          //             ],
          //           ),
          //         ),
          //         Spacer(flex: 2),
          //       ],
          //     ),
          //   ),
          //   // child: Padding(
          //   //   padding: const EdgeInsets.all(16.0),
          //   //   child: ListView(
          //   //     children: [
          //   //       CircleAvatar(
          //   //         maxRadius: 70,
          //   //         child: Text('Personal Picture'),
          //   //       ),
          //   //       SizedBox(
          //   //         height: 90,
          //   //       ),
          //   //       TextField(
          //   //         // textAlign: TextAlign.center,
          //   //         decoration: InputDecoration(
          //   //           hintText: 'Your Email...',
          //   //           hintStyle: TextStyle(
          //   //             fontSize: 20,
          //   //           ),
          //   //           contentPadding: EdgeInsets.symmetric(
          //   //             vertical: 15,
          //   //             horizontal: 20,
          //   //           ),
          //   //           border: OutlineInputBorder(
          //   //             borderRadius: BorderRadius.all(
          //   //               Radius.circular(10),
          //   //             ),
          //   //           ),
          //   //           enabledBorder: OutlineInputBorder(
          //   //             borderSide: BorderSide(
          //   //               color: Get.isDarkMode ? Colors.pink : Colors.black,
          //   //               width: 2,
          //   //             ),
          //   //             borderRadius: BorderRadius.all(
          //   //               Radius.circular(10),
          //   //             ),
          //   //           ),
          //   //           focusedBorder: OutlineInputBorder(
          //   //             borderSide: BorderSide(
          //   //               color: Get.isDarkMode ? Colors.pink : Colors.black,
          //   //               width: 8,
          //   //             ),
          //   //             borderRadius: BorderRadius.all(
          //   //               Radius.circular(10),
          //   //             ),
          //   //           ),
          //   //         ),
          //   //       ),
          //   //       SizedBox(
          //   //         height: 20,
          //   //       ),
          //   //       TextField(
          //   //         // textAlign: TextAlign.center,
          //   //         decoration: InputDecoration(
          //   //           hintText: 'Your Password...',
          //   //           hintStyle: TextStyle(
          //   //             fontSize: 20,
          //   //           ),
          //   //           contentPadding: EdgeInsets.symmetric(
          //   //             vertical: 15,
          //   //             horizontal: 20,
          //   //           ),
          //   //           border: OutlineInputBorder(
          //   //             borderRadius: BorderRadius.all(
          //   //               Radius.circular(10),
          //   //             ),
          //   //           ),
          //   //           enabledBorder: OutlineInputBorder(
          //   //             borderSide: BorderSide(
          //   //               color: Get.isDarkMode ? Colors.pink : Colors.black,
          //   //               width: 2,
          //   //             ),
          //   //             borderRadius: BorderRadius.all(
          //   //               Radius.circular(10),
          //   //             ),
          //   //           ),
          //   //           focusedBorder: OutlineInputBorder(
          //   //             borderSide: BorderSide(
          //   //               color: Get.isDarkMode ? Colors.pink : Colors.black,
          //   //               width: 8,
          //   //             ),
          //   //             borderRadius: BorderRadius.all(
          //   //               Radius.circular(10),
          //   //             ),
          //   //           ),
          //   //         ),
          //   //       ),
          //   //       SizedBox(
          //   //         height: 60,
          //   //       ),
          //   //       Row(
          //   //         children: [
          //   //           ElevatedButton(
          //   //             onPressed: () {
          //   //               Get.snackbar(
          //   //                 '', '',
          //   //                 titleText: Row(
          //   //                   mainAxisAlignment: MainAxisAlignment.center,
          //   //                   children: [
          //   //                     InkWell(
          //   //                       onTap: () {},
          //   //                       child: Column(
          //   //                         children: [
          //   //                           Text('Camera',
          //   //                               style: TextStyle(
          //   //                                   color: Get.isDarkMode
          //   //                                       ? Colors.pink
          //   //                                       : Colors.black)),
          //   //                           Icon(Icons.camera_alt,
          //   //                               size: 40,
          //   //                               color: Get.isDarkMode
          //   //                                   ? Colors.pink
          //   //                                   : Colors.black),
          //   //                         ],
          //   //                       ),
          //   //                     ),
          //   //                     SizedBox(width: 60),
          //   //                     InkWell(
          //   //                       onTap: () {},
          //   //                       child: Column(
          //   //                         children: [
          //   //                           Text('Studio',
          //   //                               style: TextStyle(
          //   //                                   color: Get.isDarkMode
          //   //                                       ? Colors.pink
          //   //                                       : Colors.black)),
          //   //                           Icon(Icons.photo,
          //   //                               size: 40,
          //   //                               color: Get.isDarkMode
          //   //                                   ? Colors.pink
          //   //                                   : Colors.black),
          //   //                         ],
          //   //                       ),
          //   //                     ),
          //   //                   ],
          //   //                 ),
          //   //                 // messageText: InkWell(onTap: (){},child: Text('Message')),
          //   //                 snackPosition: SnackPosition.BOTTOM,
          //   //                 duration: Duration(
          //   //                   seconds: 10,
          //   //                 ),
          //   //               );
          //   //               // Get.bottomSheet(
          //   //               //   Text('HIIIIIIIIIIIIIII'),
          //   //               //   backgroundColor: Colors.white,
          //   //               // );
          //   //             },
          //   //             child: Text(
          //   //               'ADD IMAGE PROFILE',
          //   //               style: TextStyle(color: Colors.white, fontSize: 18),
          //   //             ),
          //   //             style: ElevatedButton.styleFrom(
          //   //               padding: EdgeInsets.only(
          //   //                 bottom: 17,
          //   //                 top: 17,
          //   //                 left: 40,
          //   //                 right: 40,
          //   //               ),
          //   //               primary: Get.isDarkMode ? Colors.pink : Colors.black,
          //   //               elevation: 30,
          //   //             ),
          //   //           ),
          //   //           SizedBox(width: 50),
          //   //         ],
          //   //       ),
          //   //       SizedBox(
          //   //         height: 30,
          //   //       ),
          //   //       ElevatedButton(
          //   //         onPressed: () {},
          //   //         child: Text(
          //   //           'SAVE CHANGES',
          //   //           style: TextStyle(color: Colors.white, fontSize: 18),
          //   //         ),
          //   //         style: ElevatedButton.styleFrom(
          //   //           padding: EdgeInsets.only(
          //   //             bottom: 17,
          //   //             top: 17,
          //   //             left: 40,
          //   //             right: 40,
          //   //           ),
          //   //           primary: Get.isDarkMode ? Colors.pink : Colors.black,
          //   //           elevation: 30,
          //   //         ),
          //   //       ),
          //   //     ],
          //   //   ),
          //   // ),
          // ),
        ],
      ),
    );
  }
}
