

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: ListView(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 35,),
                    Container(
                      alignment: Alignment.center,
                      width: 90,
                      height: 90,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(65),
                      ),
                      child: Image.asset("images/note.jpg",
                        height: 80,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
    );
  }
}
