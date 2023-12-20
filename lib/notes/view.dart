
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pushnotification/Categories/edit.dart';
import 'package:pushnotification/notes/add.dart';
import 'package:pushnotification/notes/edit.dart';

class noteView extends StatefulWidget {
  final String categoryID;
  final String CategoryName;
  const noteView({Key? key, required this.categoryID, required this.CategoryName}) : super(key: key);

  @override
  State<noteView> createState() => _noteViewState();
}

class _noteViewState extends State<noteView> {
  List <QueryDocumentSnapshot> data =[];
  bool isLoading = true;
  getData() async {
    QuerySnapshot querySnapshot
    = await FirebaseFirestore.instance.collection("categories").doc(widget.categoryID).collection("note").get();
    data.addAll(querySnapshot.docs);
    isLoading = false;
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
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => addNote(docId: widget.categoryID,)));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("${widget.CategoryName}"),
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
      body:WillPopScope(
        child: isLoading ? Center(
          child: CircularProgressIndicator(),
        ) :
        ListView.builder(
          itemCount: data.length,
          padding: EdgeInsets.all(10),
          itemBuilder: (context, i) {
           return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              margin: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        FittedBox(child: Text("${data[i]["note"]}")),
                        Spacer(),
                        IconButton(
                          color: Colors.red,
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            await FirebaseFirestore.instance.collection("categories")
                                .doc(widget.categoryID).collection("note").doc(data[i].id).delete();
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => noteView(categoryID: widget.categoryID,
                                        CategoryName: "",))
                                    );

                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('You have successfully deleted a note'),
                            ));
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: (){
                            Navigator.of(context).push
                              (MaterialPageRoute(builder: (context) =>
                                editNote(categoryDocId: widget.categoryID, noteDocId: data[i].id, value: data[i]["note"],)));
                          },
                        ),
                      ],
                    ),
                  )

                ],
              ),
            );

          },


        ),
        onWillPop: () {
          Navigator.of(context).pushNamedAndRemoveUntil("homepage", (route) => false);
          return Future.value(false);
        },
      ),

    );
  }
}
