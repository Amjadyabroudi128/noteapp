import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextAdd extends StatelessWidget {
  final String hinttext;
  final TextEditingController myController;

  const CustomTextAdd
  ({ required this.hinttext,
  required this.myController,
});
@override
Widget build(BuildContext context) {
  return TextFormField(
    controller: myController,
    decoration: InputDecoration(
        hintText: hinttext,
        hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.grey),

        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
                color: Colors.grey
            )
        )
    ),
  );
  // custom text field
}
}
