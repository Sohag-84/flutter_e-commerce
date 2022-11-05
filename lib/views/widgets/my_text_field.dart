import 'package:flutter/material.dart';

Widget myTextField({
  required String hintText,
  required keyBoardType,
  required controller,
}) {
  return TextField(
    keyboardType: keyBoardType,
    controller: controller,
    decoration: InputDecoration(hintText: hintText),
  );
}
