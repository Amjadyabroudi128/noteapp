
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pushnotification/components/CostomButton.dart';
import 'package:pushnotification/components/customlogoauth.dart';
import 'package:pushnotification/components/textformfield.dart';

import '../homepage.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailcontroller = TextEditingController();
  final passwordController = TextEditingController();
  final userController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
        )
    );
    // this is to remove the status bar

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 35,),
                    CustomLogo(),
                    SizedBox(height: 15,),
                    Text("SignUp", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Text("SignUp to continue using the app", style: TextStyle( color: Colors.grey),),
                    SizedBox(height: 20,),
                    Text("User",style: TextStyle( fontWeight: FontWeight.bold),),
                    SizedBox(height: 9,),
                    CustomTextForm(hinttext: "enter your username", myController: userController),
                    Text("Email", style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 9,),
                    CustomTextForm(hinttext: "enter email", myController: emailcontroller),
                    SizedBox(height: 9,),
                    Text("Password", style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 9,),
                    CustomTextForm(hinttext: 'Password', myController: passwordController,),
                    Container(
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        alignment: Alignment.topRight,
                        child: Text("forgot passowrd?"))
                  ],
                )
            ),
            CustomButton(onPressed: ()async {
          try {
            final auth = await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailcontroller.text,
              password: passwordController.text,
            );
            Navigator.of(context).pushReplacementNamed("homepage");
          } on FirebaseAuthException catch (e) {
            if (e.code == 'weak-password') {
              print('The password provided is too weak.');
            } else if (e.code == 'email-already-in-use') {
              print('The account already exists for that email.');
            }
          } catch (e) {
            print(e);
          }
        }, title: "SignUp"),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("already a user?"),
                SizedBox(width: 5,),
                TextButton(
                  child: Text("Login"),
                  onPressed: (){
                    Navigator.of(context).pushNamed("login");
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
