import 'package:flutter/material.dart';

//display error msg
void displayErrorMessage(String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(message),
    ),
  );
}
