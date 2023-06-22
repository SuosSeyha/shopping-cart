
import 'package:flutter/material.dart';
void replaceScreen(context, page){
  Navigator.pushReplacement(
    context,MaterialPageRoute(
      builder: (context) {
        return page;
      },));
}

void nextScreen(context, page){
  Navigator.push(
    context,MaterialPageRoute(
      builder: (context) {
        return page;
      },));
}
