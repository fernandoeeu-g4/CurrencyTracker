import 'package:flutter/material.dart';

class Styles {
  static List<BoxShadow> defaultBoxShadow ({ shadowColor }) {
    return [
      BoxShadow(
        color: shadowColor != null ? shadowColor : Colors.black.withOpacity(0.1),
        offset: Offset(
          1.0, // horizontal, move right 10
          1.0, // vertical, move down 10
        ),
        blurRadius: 10.0,
        spreadRadius: 1.0,
      )
    ];
  } 
}