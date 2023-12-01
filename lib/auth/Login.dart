

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pushnotification/components/CostomButton.dart';
import 'package:pushnotification/components/customlogoauth.dart';
import 'package:pushnotification/components/textformfield.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                    Text("Login", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Text("Login to continue using the app", style: TextStyle( color: Colors.grey),),
                    SizedBox(height: 20,),
                    Text("Email", style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 9,),
                    CustomTextForm(hinttext: "enter email", myController: email),
                    SizedBox(height: 9,),
                    Text("Password", style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 9,),
                    CustomTextForm(hinttext: 'Password', myController: password,),
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      alignment: Alignment.topRight,
                        child: Text("forgot passowrd?"))
                  ],
                )
              ),
              CustomButton(onPressed: (){}, title: "Login"),
              SizedBox(height: 10,),
              MaterialButton(
                  height: 40,
                  color: Colors.red,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  onPressed: (){},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("login with google"),
                      SizedBox(width: 10,),
                      Image.asset("images/google.png", width: 30,),
                    ],
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Dont have an account?"),
                  SizedBox(width: 5,),
                  TextButton(
                    child: Text("Register"),
                    onPressed: (){
                      Navigator.of(context).pushReplacementNamed("signup");
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
