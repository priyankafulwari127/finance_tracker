import 'package:flutter/material.dart';

Widget TextFields(TextEditingController controller, String hintText) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      border: InputBorder.none,
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            12,
          ),
        ),
        borderSide: BorderSide.none,
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            12,
          ),
        ),
        borderSide: BorderSide(color: Colors.deepPurple),
      ),
      hintText: hintText,
      fillColor: Colors.grey[300],
      filled: true,
    ),
  );
}