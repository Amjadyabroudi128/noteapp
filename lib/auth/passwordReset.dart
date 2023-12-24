import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pushnotification/components/CostomButton.dart';
import 'package:pushnotification/components/CustomTextFieldAdd.dart';

import '../components/textformfield.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({Key? key}) : super(key: key);

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            SizedBox(height: 120,),
            Column(

                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text("enter the email associated with your account to reset password",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  ),
                  SizedBox(height: 14,),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: CustomTextForm(hinttext: "enter email",
                      myController: emailController,
                      SuffixIcon: Icon(Icons.email, color: Colors.black,),),
                  ),
                  SizedBox(height: 12,),
                  CustomButton(
                    title: "Send",
                    onPressed: () async {
                        await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
                        ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                            content: Text("check your email to reset passowrd")
                        ));
                        Navigator.of(context).pushNamed("login");

                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("or", style: TextStyle(fontSize: 25),),
                        InkWell(
                          onTap: (){
                            Navigator.of(context).pushNamed("login");
                          },
                          child: Container(
                              margin: EdgeInsets.only(top: 20, bottom: 20),
                              alignment: Alignment.topRight,
                              child: Text(" login", style: TextStyle(color: Colors.red, fontSize: 25),)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
