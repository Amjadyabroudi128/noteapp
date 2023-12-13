import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List <QueryDocumentSnapshot> data =[];

  getData() async {
   QuerySnapshot querySnapshot  = await FirebaseFirestore.instance.collection("categories").get();
   data.addAll(querySnapshot.docs);
   setState(() {

   });
  }
  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        )
    );
    // this is to remove the status bar
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushNamed("addcategory");
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("hello"),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
            ),
            onPressed: () async {
              GoogleSignIn googleSignIn = GoogleSignIn();
              googleSignIn.disconnect();
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil("login", (route) => false);
            },
          ),
        ],
      ),
      body: GridView.builder(
        itemCount: data.length,
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisExtent: 150,
        ),
        itemBuilder: (context, i) {
         return Card(
           margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
           child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
               children: [
                 Image.asset("images/folder.png",
                   height: 100,
                 ),

                 Text("${data[i]["name"]}"),
               ],
              ),
            ),
          );
        },


      ),
    );
  }
}
