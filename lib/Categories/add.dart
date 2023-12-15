import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pushnotification/components/CostomButton.dart';
import 'package:pushnotification/components/CustomTextFieldAdd.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  CollectionReference categories = FirebaseFirestore.instance.collection("categories");

  AddCategory () async {

    if (formState.currentState!.validate()){
      try {
        DocumentReference response = await categories.add(
          {"name": name.text, "email" : FirebaseAuth.instance.currentUser!.email}
        );
        Navigator.of(context).pushNamedAndRemoveUntil("homepage", (route) => false);
      } catch(e) {
        print("error ${e}");
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Category"),
      ),
      body: Form(
        key: formState,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                child: CustomTextAdd(hinttext: "name", myController: name)),
            CustomButton(onPressed: (){
              AddCategory();
            }, title: "add")
          ],
        ),
      ),
    );
  }
}
