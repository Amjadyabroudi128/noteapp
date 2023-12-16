import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pushnotification/components/CostomButton.dart';
import 'package:pushnotification/components/CustomTextFieldAdd.dart';
import 'package:pushnotification/notes/view.dart';

class editNote extends StatefulWidget {
  final String noteDocId;
  final String categoryDocId;
  final String value;
  const editNote({Key? key,   required this.categoryDocId, required this.noteDocId, required this.value}) : super(key: key);

  @override
  State<editNote> createState() => _editNoteState();
}

class _editNoteState extends State<editNote> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController note = TextEditingController();

  editNote () async {
    CollectionReference collectioNote =
    FirebaseFirestore.instance.collection("categories")
        .doc(widget.categoryDocId).collection("note");

    if (formState.currentState!.validate()){
      try {
         await collectioNote.doc(widget.noteDocId).update({
           "note" : note.text
         });
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => noteView(categoryID: widget.categoryDocId)
          ),
        );
      } catch(e) {
        print("error ${e}");
      }
    }
  }
  @override
  void initState() {
    note.text = widget.value;
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    note.dispose();
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
              editNote();
            }, title: "save")
          ],
        ),
      ),
    );
  }
}
