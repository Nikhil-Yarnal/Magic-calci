// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  const CalculatorButton({
    super.key,
    required this.text,
    required this.buttonColor,
    required this.textColor,
    required this.textSize,
    required this.onPressed,
  });

  final String text;
  final int textColor;
  final int buttonColor;
  final double textSize;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: SizedBox(
        width: 62,
        height: 62,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Color(buttonColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => onPressed(text),
          child: Text(
            text,
            style: TextStyle(
              fontSize: textSize,
              color: Color(textColor),
            ),
          ),
        ),
      ),
    );
  }
}
