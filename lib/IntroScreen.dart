
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IntroductionScreen(
          globalBackgroundColor: Colors.white,
          scrollPhysics: BouncingScrollPhysics(),
          pages: [
            PageViewModel(
              title: "",
              bodyWidget: Column(
                children: [
                  SizedBox(height: 60,),
                  Image(
                      image: AssetImage("images/login.png"),
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 60,),
                  Text("Login with and start taking notes", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                  SizedBox(height: 40,),
                  Text("You can sign in with both your email and gmail ")
                ],
              )
            ),
            PageViewModel(
                title: "",
                bodyWidget: Column(
                  children: [
                    SizedBox(height: 60,),
                    Image(
                      image: AssetImage("images/home.png"),
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 60,),
                    Text("Login with and start taking notes", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                    SizedBox(height: 40,),
                    Text("You can sign in with both your email and gmail ")
                  ],
                )
            ),
            PageViewModel(
                title: "",
                bodyWidget: Column(
                  children: [
                    SizedBox(height: 60,),
                    Image(
                      image: AssetImage("images/note.png"),
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 60,),
                    Text("Login with and start taking notes", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                    SizedBox(height: 40,),
                    Text("You can sign in with both your email and gmail ")
                  ],
                )
            ),
          ],
          onDone: (){
            Navigator.of(context).pushNamed("login");
          },
          onSkip: (){
            Navigator.of(context).pushNamed("login");

          },
          showSkipButton: true,
          skip: Text("Skip", style: TextStyle(color: Colors.orangeAccent),),
          next: Icon(Icons.arrow_forward, color: Colors.red,),
          back: Icon(Icons.arrow_back, color: Colors.orange,),
          done: Text("done"),
          dotsDecorator: DotsDecorator(
              size: Size.square(10.0),
              activeSize: Size(20.0, 10.0),
              color: Colors.orange,
              activeColor: Colors.red,
              spacing: EdgeInsets.symmetric(horizontal: 3.0,),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(23),

              )
          ),
        ),
      ),

    );
  }
}
