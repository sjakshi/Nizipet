import 'package:flutter/material.dart';

Image logoWidget(String imagename){
  return Image.asset(
    imagename,
    fit:BoxFit.fitWidth,
    width: 240,
    height: 240,
    // color: Colors.white,
    color: Color(0xFF000033),
  );
}