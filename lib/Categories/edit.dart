import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pushnotification/components/CostomButton.dart';
import 'package:pushnotification/components/CustomTextFieldAdd.dart';

class editCategory extends StatefulWidget {
  final String DocId;
  final String oldname;
  const editCategory({Key? key, required this.DocId, required this.oldname}) : super(key: key);

  @override
  State<editCategory> createState() => _editCategoryState();
}

class _editCategoryState extends State<editCategory> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  CollectionReference categories = FirebaseFirestore.instance.collection("categories");

  editCategory () async {

    if (formState.currentState!.validate()){
      try {
          await categories.doc(widget.DocId).update({
            "name" : name.text
          });

        Navigator.of(context).pushNamedAndRemoveUntil("homepage", (route) => false);
      } catch(e) {
        print("error ${e}");
      }
    }
  }
  @override
  void initState() {
    super.initState();
    name.text = widget.oldname;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("edit Category"),
      ),
      body: Form(
        key: formState,
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                child: CustomTextAdd(hinttext: "name", myController: name)),
            CustomButton(onPressed: (){
              editCategory();
            }, title: "save")
          ],
        ),
      ),
    );
  }
}
