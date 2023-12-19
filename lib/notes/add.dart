import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pushnotification/components/CostomButton.dart';
import 'package:pushnotification/components/CustomTextFieldAdd.dart';
import 'package:pushnotification/notes/view.dart';

class addNote extends StatefulWidget {
  final docId;
  const addNote({Key? key, required this.docId}) : super(key: key);

  @override
  State<addNote> createState() => _addNoteState();
}

class _addNoteState extends State<addNote> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController note = TextEditingController();

  addNote () async {
    CollectionReference collectioNote = FirebaseFirestore.instance.collection("categories").doc(widget.docId).collection("note");

    if (formState.currentState!.validate()){
      try {
        DocumentReference response = await collectioNote.add(
            {"note": note.text,}
        );
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => noteView(categoryID: widget.docId, CategoryName: '',)
          ),
        );
      } catch(e) {
        print("error ${e}");
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add note"),
      ),
      body: Form(
        key: formState,
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                child: CustomTextAdd(hinttext: "note", myController: note)),
            CustomButton(onPressed: (){
              addNote();
            }, title: "add")
          ],
        ),
      ),
    );
  }
}
