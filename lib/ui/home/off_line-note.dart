import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_notes/controllers/sqflite.dart';
import 'package:my_notes/widgets/my_button.dart';
import '../add_edit/edit_note_off_line.dart';
import 'home.dart';

// import 'package:sqfnote/edit_note.dart';
// import 'package:sqfnote/sqflite.dart';

class OffLineHome extends StatefulWidget {
  const OffLineHome({Key? key}) : super(key: key);

  @override
  State<OffLineHome> createState() => _OffLineHomeState();
}

class _OffLineHomeState extends State<OffLineHome> {
  SqlDb sqlDb = SqlDb();
  List notes = [];

  Future readData() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM notes");
    notes.addAll(response);
    if (mounted) {
      setState(() {});
    }
  }

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();

  @override
  void initState() {
    readData();
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        width: 450,
        shape: OutlineInputBorder(
          borderSide: BorderSide(width: 0,style: BorderStyle.none),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(490),
                topRight: Radius.circular(490))),
        child: ListView(
          children:
          [
            SizedBox(
              height: 150,
            ),
            UserAccountsDrawerHeader(
              accountName: Center(
                  child: Text(
                'Write Your Note   ',
                style: TextStyle(fontSize: 18),
              )),
              accountEmail: ClipRRect(child: Text('')),
              // currentAccountPicture: CircleAvatar(
              //   backgroundImage: NetworkImage(
              //       "http://meaningnames.net/Diwani/Hisham-Name-in-Arabic-Calligraphy.jpg"),
              // ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    "https://media.vanityfair.com/photos/5e8f9f875752fb00088317c4/16:9/w_1280,c_limit/The-Art-of-Making-Art-About-a-Plague.jpg",
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              otherAccountsPictures: [],
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Form(
                    key: formstate,
                    child: Column(
                      children: [
                        Material(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(17),
                          elevation: 40,
                          child: TextFormField(
                            controller: note,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(17),
                                  borderSide:
                                      const BorderSide(color: Colors.white12)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(17),
                                  borderSide:
                                      const BorderSide(color: Colors.white12)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Material(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(17),
                          elevation: 40,
                          child: TextFormField(
                            controller: title,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(17),
                                  borderSide:
                                      const BorderSide(color: Colors.white12)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(17),
                                  borderSide:
                                      const BorderSide(color: Colors.white12)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MyButton(
                          onPressed: () async {
                            int response = await sqlDb.insertData('''
                                      INSERT INTO notes (note, title)
                                      VALUES ("${note.text}", "${title.text}")
                                      ''');
                            if (response > 0) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const OffLineHome(),
                                  ),
                                  (route) => false);
                            }
                          },
                          title: 'ADD',
                          color: Get.isDarkMode ? Colors.pink : Color(0xFFFF6B6B),
                          Width: 140,
                        ),
                        // MaterialButton(
                        //     onPressed: () async {
                        //       int response =
                        //       await sqlDb.insertData('''
                        //               INSERT INTO notes (note, title)
                        //               VALUES ("${note.text}", "${title.text}")
                        //               ''');
                        //       if (response > 0) {
                        //         // ignore: use_build_context_synchronously
                        //         Navigator.pushAndRemoveUntil(
                        //             context,
                        //             MaterialPageRoute(
                        //               builder: (context) =>
                        //               const OffLineHome(),
                        //             ),
                        //                 (route) => false);
                        //       }
                        //     },
                        //     color: Colors.black,
                        //     elevation: 30,
                        //     child: const Text('ADD')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 350,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.pink,
          onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          // onPressed: () {
          //   showDialog(
          //       context: context,
          //       builder: (context) {
          //         return AlertDialog(
          //           backgroundColor: Colors.pink,
          //           content: SizedBox(
          //               height: 200,
          //               child: ListView(
          //                 children: [
          //                   Form(
          //                     key: formstate,
          //                     child: Column(
          //                       children: [
          //                         Material(
          //                           color: Colors.black54,
          //                           borderRadius: BorderRadius.circular(17),
          //                           elevation: 40,
          //                           child: TextFormField(
          //                             controller: note,
          //                             decoration: InputDecoration(
          //                               enabledBorder: OutlineInputBorder(
          //                                   borderRadius:
          //                                       BorderRadius.circular(17),
          //                                   borderSide: const BorderSide(
          //                                       color: Colors.white12)),
          //                               focusedBorder: OutlineInputBorder(
          //                                   borderRadius:
          //                                       BorderRadius.circular(17),
          //                                   borderSide: const BorderSide(
          //                                       color: Colors.white12)),
          //                             ),
          //                           ),
          //                         ),
          //                         const SizedBox(
          //                           height: 10,
          //                         ),
          //                         Material(
          //                           color: Colors.black54,
          //                           borderRadius: BorderRadius.circular(17),
          //                           elevation: 40,
          //                           child: TextFormField(
          //                             controller: title,
          //                             decoration: InputDecoration(
          //                               enabledBorder: OutlineInputBorder(
          //                                   borderRadius:
          //                                       BorderRadius.circular(17),
          //                                   borderSide: const BorderSide(
          //                                       color: Colors.white12)),
          //                               focusedBorder: OutlineInputBorder(
          //                                   borderRadius:
          //                                       BorderRadius.circular(17),
          //                                   borderSide: const BorderSide(
          //                                       color: Colors.white12)),
          //                             ),
          //                           ),
          //                         ),
          //                         const SizedBox(
          //                           height: 20,
          //                         ),
          //                         MaterialButton(
          //                             onPressed: () async {
          //                               int response =
          //                                   await sqlDb.insertData('''
          //                           INSERT INTO notes (note, title)
          //                           VALUES ("${note.text}", "${title.text}")
          //                           ''');
          //                               if (response > 0) {
          //                                 // ignore: use_build_context_synchronously
          //                                 Navigator.pushAndRemoveUntil(
          //                                     context,
          //                                     MaterialPageRoute(
          //                                       builder: (context) =>
          //                                           const OffLineHome(),
          //                                     ),
          //                                     (route) => false);
          //                               }
          //                             },
          //                             color: Colors.black,
          //                             elevation: 30,
          //                             child: const Text('ADD')),
          //                       ],
          //                     ),
          //                   ),
          //                 ],
          //               )),
          //         );
          //       });
          // },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
      // appBar: AppBar(
      //   backgroundColor: Colors.pink,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.vertical(
      //       bottom: Radius.circular(30),
      //     ),
      //   ),
      //   leading: IconButton(
      //       onPressed: () {
      //         Get.to(Home());
      //       },
      //       icon: Icon(
      //         Icons.arrow_back,
      //         color: Get.isDarkMode ? Colors.white : Colors.black,
      //       )),
      //   title: Text('MEMO'),
      //   centerTitle: true,
      // ),
      body: Container(
        color: Color(0xff303030),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              height: 200.0,
              decoration: new BoxDecoration(
                color: Colors.pink,
                boxShadow: [
                  new BoxShadow(blurRadius: 40.0)
                ],
                borderRadius: new BorderRadius.vertical(
                    bottom: new Radius.elliptical(
                        MediaQuery.of(context).size.width, 100.0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                [
                  IconButton(
                      onPressed: (){
                        Get.offAll(Home());
                      },
                      icon: Icon(Icons.arrow_back_ios)),
                  Spacer(
                    flex: 10,
                  ),
                  Text(
                      'MEMO',
                      style: TextStyle(
                        fontFamily: 'Pacifico',
                        fontSize: 25
                      )),
                  Spacer(
                    flex: 15,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ListView.builder(
              itemCount: notes.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, i) {
                return Dismissible(
                    onDismissed: (direction) async {
                      int response = await await sqlDb.deleteData(
                          "DELETE FROM 'notes' WHERE id = ${notes[i]['id']}");
                      if (response > 0) {
                        notes.removeWhere(
                            (element) => element['id'] == notes[i]['id']);
                      }
                    },
                    key: UniqueKey(),
                    child: Card(
                      child: ListTile(
                        title: Text("${notes[i]['note']}"),
                        subtitle: Text("${notes[i]['title']}"),
                        trailing: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditNotesOffLine(
                                      id: notes[i]['id'],
                                      note: notes[i]['note'],
                                      title: notes[i]['title'],
                                    ),
                                  ));
                            },
                            icon: const Icon(Icons.edit)),
                      ),
                    ));
              },
            )
          ],
        ),
      ),
    );
  }
}
