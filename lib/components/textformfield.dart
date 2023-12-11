import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String hinttext;
  final TextEditingController myController;
  final bool? isObscureText;
  final Widget? SuffixIcon;
 const CustomTextForm
  ({ required this.hinttext,
  required this.myController,
  required, this.isObscureText = false,
  required this.SuffixIcon
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscureText!,
      controller: myController,
      decoration: InputDecoration(
          hintText: hinttext,
          suffixIcon: SuffixIcon!,
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
