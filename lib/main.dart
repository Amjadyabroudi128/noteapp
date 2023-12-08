import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pushnotification/auth/Registration.dart';

import 'auth/Login.dart';
import 'homepage.dart';

 Future <void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
     options: FirebaseOptions(
         apiKey: "AIzaSyAcjOF2Q7TiEJ4Cx_eI0IZYWcnycmxLq44",
         appId: "pushnotification-edda3",
         messagingSenderId:
         "765754690122",
         projectId: "pushnotification-edda3"
     ),
   );
   GoogleSignIn();
   runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (FirebaseAuth.instance.currentUser != null
          && FirebaseAuth.instance.currentUser!.emailVerified)
          ? HomePage()
          : Login(),

      routes: {
        "signup" : (context) => SignUp(),
        "login" : (context) => Login(),
        "homepage" : (context) => HomePage(),
      },
      // routes for the pages
    );
  }
}

