
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
  bool passwordVisible=false;
  bool _validate = false;

  @override
  void initState(){
    super.initState();
    passwordVisible=true;
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
                    Text("Welcome", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Text("Please Sign up here ", style: TextStyle( color: Colors.grey),),
                    SizedBox(height: 20,),
                    Text("User",style: TextStyle( fontWeight: FontWeight.bold),),
                    SizedBox(height: 9,),
                    CustomTextForm(hinttext: "enter your username", myController: userController,
                      SuffixIcon: Icon(Icons.person, color: Colors.black,),),
                    Text("Email", style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 9,),
                    CustomTextForm(hinttext: "enter email",
                      myController: emailcontroller,
                      SuffixIcon: Icon(Icons.email, color: Colors.black,),),
                    SizedBox(height: 9,),
                    Text("Password", style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 9,),
                    CustomTextForm(
                      hinttext: 'Password',
                      isObscureText: passwordVisible,
                      myController: passwordController,
                      SuffixIcon: IconButton(
                        color: Colors.black,
                        icon: Icon(
                            passwordVisible ? Icons.visibility : Icons.visibility_off),
                        onPressed: (){
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                      ),
                    ),
                  ],
                )
            ),
            SizedBox(height: 10,),
            CustomButton(onPressed: ()async {
          try {
            final auth = await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailcontroller.text,
              password: passwordController.text,
            );
            FirebaseAuth.instance.currentUser!.sendEmailVerification();
            ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                content: Text("we just sent you a verification email")
            ));
            Navigator.of(context).pushReplacementNamed("login");
          } on FirebaseAuthException catch (e) {
            if (e.code == 'weak-password') {
              ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                  content: Text("password is week")
              ));
            } else if (e.code == 'email-already-in-use') {
              ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                  content: Text("account already exists")
              ));
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
