import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_notes/ui/auth/login_admin.dart';

class AdminHome extends StatefulWidget {
  AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {


  var getData = FirebaseFirestore.instance.collection('users').get();

  // del()async{
  //   await FirebaseAuth.instance.;
  //   // await FirebaseAuth.instance.currentUser!.delete();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                      Get.offAll(LoginAdmin());
                    },
                    icon: Icon(Icons.arrow_back_ios)),
                Spacer(
                  flex: 10,
                ),
                Text(
                    'Admin',
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
          Container(
            height: 550,
            child: FutureBuilder(
              future: getData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, i) {
                      return Card(
                        child: ListTile(
                          leading: Text('${snapshot.data!.docs[i]['email']}'),
                          title: Text('${snapshot.data!.docs[i]['name']}'),
                          trailing: IconButton(
                            onPressed: ()async{

                            },
                            icon: Icon(Icons.delete_forever),
                          ),
                        ),
                      );
                    },
                  );
                }
                if (snapshot.hasError) {
                  return Text('Error');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading');
                }
                return Text('Load');
              },
            ),
          ),
        ],
      ),
    );
  }
}
