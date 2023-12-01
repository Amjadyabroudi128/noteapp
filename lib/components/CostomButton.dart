import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function ()? onPressed;
 final String title;
  const CustomButton({ super.key, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {

    return MaterialButton(
        height: 40,
        color: Colors.orange,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: (){},
        child: Text(title));
  }
}
