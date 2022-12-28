// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, unused_field


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uas_pab_adam/views/login.dart';
import 'package:uas_pab_adam/views/utils/pallete.dart';

class Teacher extends StatefulWidget {
  const Teacher({super.key});

  @override
  State<Teacher> createState() => _TeacherState();
}

class _TeacherState extends State<Teacher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // custom app bar
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => logout(context),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: primaryColorsBackground,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      Icons.logout,
                      color: primaryColors,
                      size: 20.0,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  'Teacher',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}
