// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, unused_field, unused_local_variable, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:uas_pab_adam/views/utils/pallete.dart';

// ignore: must_be_immutable
class CustomFormField extends StatelessWidget {
  String hintName;
  TextEditingController controller;
  TextInputType keyboardType;
  CustomFormField({super.key, required this.controller, required this.hintName, required this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      style: TextStyle(fontSize: 16),
      decoration: InputDecoration(
        hintText: hintName,
        filled: true,
        fillColor: primaryColorsBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.only(top: 10, left: 20),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please Enter $hintName';
        }
        return null;
      }
    );
  }
}
