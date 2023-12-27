import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pushnotification/Categories/edit.dart';
import 'package:pushnotification/notes/view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  List <QueryDocumentSnapshot> data =[];
  bool isLoading = true;
  User? user = FirebaseAuth.instance.currentUser;
  bool didVote = false;
  getData() async {
   QuerySnapshot querySnapshot
   = await FirebaseFirestore.instance.collection("categories")
       .where("email", isEqualTo: FirebaseAuth.instance.currentUser!.email).get();
   data.addAll(querySnapshot.docs);
   isLoading = false;
   setState(() {

   });
  }
  @override
  void initState() {
    getData();
    super.initState();
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

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushNamed("addcategory");
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("${user!.email}"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
            ),
            onPressed: () async {
              await _showMyDialog();
              GoogleSignIn googleSignIn = GoogleSignIn();
              googleSignIn.disconnect();
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil("login", (route) => false);
            },
          ),
        ],
      ),
      body:isLoading ? Center(

        child: CircularProgressIndicator(),
      ) :
      GridView.builder(
        itemCount: data.length,
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisExtent: 150,
        ),
        itemBuilder: (context, i) {
         return InkWell(
           onDoubleTap: (){
             Share.share("${(data)[i]["name"]}", subject: "does it work");
           },
           onTap: (){
             Navigator.of(context).push(MaterialPageRoute(builder: (context) => noteView(categoryID: data[i].id,
               CategoryName: "${data[i]["name"]}",)));
           },
           onLongPress: ()async{
             AwesomeDialog(
               context: context,
               dialogType: DialogType.warning,
               animType: AnimType.rightSlide,
               title: "edit  ${data[i]["name"]}",
               desc: "you can edit or delete ",
               btnCancelText: "delete",
               btnOkText: "edit",
               btnCancelOnPress: ()async {
                 await FirebaseFirestore.instance.collection("categories").doc(data[i].id).delete();
                 Navigator.of(context).pushReplacementNamed("homepage");
               },
               btnOkOnPress: () async {
                 Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                     editCategory(DocId: data[i].id, oldname: data[i]["name"])));
               }
             ).show();
           },
           child: FittedBox(
             child: Card(
               margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
               child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                   children: [
                     Image.asset("images/folder.png",
                       height: 90,
                     ),
                     SizedBox(height: 5,),
                     Text("${data[i]["name"]}"),
                   ],
                  ),
                ),
              ),
           ),
         );
        },


      ),

    );

  }
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return   AlertDialog(
          content:  SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                        child:
                        Text("Thank you for using our app", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),)),
                    SizedBox(height: 20,),
                    Text("How Was your Experience"),
                    SizedBox(height: 3,),
                    Center(
                      child: RatingBar(
                        maxRating: 5,
                        minRating: 1,
                        initialRating: 1,
                        allowHalfRating: true,
                        ratingWidget: RatingWidget(
                            full: Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            half: Icon(
                              Icons.star_half,
                            ),
                            empty: Icon(
                              Icons.star,
                              color: Colors.grey,
                            ),
                        ), onRatingUpdate: (rating) {
                      },
                        itemSize: 30,
                        itemPadding: EdgeInsets.symmetric(horizontal: 3),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[

            TextButton(
              child: const Text('Later',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: ()  {
                Navigator.pop(context);
              },
            ),
            TextButton(
                child: const Text('thanks',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: (){
                  Navigator.pop(context);
                },

            ),
          ],
        );
      },
    );
  }
}

