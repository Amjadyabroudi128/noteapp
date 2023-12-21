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
                    padding: const EdgeInsets.all(8.0),
                    child: Text("please give us your email to reset your password",
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
                        Navigator.of(context).pushNamed("login");

                    },
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}
