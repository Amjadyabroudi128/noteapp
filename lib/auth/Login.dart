
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pushnotification/components/CostomButton.dart';
import 'package:pushnotification/components/customlogoauth.dart';
import 'package:pushnotification/components/textformfield.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
 bool isLoading = false;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null){
      return;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
     await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.of(context).pushNamedAndRemoveUntil("homepage", (route) => false);
    isLoading = true;
    await Future.delayed(Duration(seconds: 3));

  }

  bool passwordVisible=false;
  @override
  void initState(){
    super.initState();
    passwordVisible=true;
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark
      )
    );
    // this is to remove the status bar

    return Scaffold(
      body:  isLoading ? Center(
        child: CircularProgressIndicator(),
      ) :Container(
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
                    Text("Welcome back", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Text("Login to continue using the app", style: TextStyle( color: Colors.grey),),
                    SizedBox(height: 20,),
                    Text("Email", style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 9,),
                    CustomTextForm(hinttext: "enter email", myController: emailController, SuffixIcon: Icon(Icons.email, color: Colors.black,),),
                    SizedBox(height: 9,),
                    Text("Password", style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 9,),
                    CustomTextForm(
                      hinttext: 'Password',
                      myController: passwordController, SuffixIcon: IconButton(
                      color: Colors.black,
                      icon: Icon(
                          passwordVisible ? Icons.visibility : Icons.visibility_off),
                      onPressed: (){
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                      isObscureText: passwordVisible,
                    ),
                    InkWell(
                      // onTap: () async {
                      //   await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
                      // },
                      onTap: (){
                        Navigator.of(context).pushNamed("reset");

                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        alignment: Alignment.topRight,
                          child: Text("forgot passowrd?")),
                    )
                  ],
                )
              ),
              CustomButton(onPressed: ()
                  async {
                    try {
                      isLoading = true;
                      setState(() {

                      });
                      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text
                      );
                      await Future.delayed(Duration(seconds: 1));
                      isLoading = false;
                      if (credential.user!.emailVerified){
                        Navigator.of(context).pushReplacementNamed("homepage");
                      } else {
                        FirebaseAuth.instance.currentUser!.sendEmailVerification();
                        ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                          content: Text("please verify your email")
                        ));
                      }
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');

                      }
                      isLoading = false;

                      setState(() {
                        clearText();
                      });
                      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                          content: Text("either password or email wrong")
                      ));
                    }
                  },
                  title: "login"),
              SizedBox(height: 10,),
              MaterialButton(
                  height: 40,
                  color: Colors.red,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  onPressed: (){
                    isLoading ? Center(
                      child: CircularProgressIndicator(),
                    ) :
                    signInWithGoogle();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("login with google"),
                      SizedBox(width: 15,),
                      Image.asset("images/google.png", width: 30,),
                    ],
                  ),
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
              ),
            ],
          ),
        ),
    );
  }
  void clearText() {
    emailController.clear();
    passwordController.clear();
  }
}
