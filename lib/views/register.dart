// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uas_pab_adam/views/login.dart';
import 'package:uas_pab_adam/views/utils/pallete.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  _RegisterPageState();

  bool showProgress = false;
  bool visible = false;

  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpassController = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  
  bool _isObscure = true;
  bool _isObscure2 = true;
  File? file;
  
  var options = [
    'Student',
    'Teacher',
  ];
  var _currentItemSelected = "Student";
  var rool = "Student";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      // heading
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Center(
                          child: Image.asset(
                            'assets/Mahasiswa-Logos.png',
                            scale: 3,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Center(
                          child: Text(
                            'Login to your account',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),

                      // email field
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 20, left: 20, top: 50),
                        child: TextFormField(
                          controller: emailController,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: primaryColorsBackground,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.only(top: 10, left: 20),
                            hintText: 'Email',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email cannot be empty";
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("Please enter a valid email");
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),

                      // pasword field
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 20, left: 20, top: 15),
                        child: TextFormField(
                          obscureText: _isObscure,
                          controller: passwordController,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: primaryColorsBackground,
                            suffixIcon: IconButton(
                              icon: Icon(_isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.only(top: 10, left: 20),
                            hintText: 'Password',
                          ),
                          validator: (value) {
                            RegExp regex = new RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return "Password cannot be empty";
                            }
                            if (!regex.hasMatch(value)) {
                              return ("please enter valid password min. 6 character");
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
                        ),
                      ),

                      // confirm pasword field
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 20, left: 20, top: 15),
                        child: TextFormField(
                          obscureText: _isObscure2,
                          controller: confirmpassController,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: primaryColorsBackground,
                            suffixIcon: IconButton(
                              icon: Icon(_isObscure2
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _isObscure2 = !_isObscure2;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.only(top: 10, left: 20),
                            hintText: 'Confirm Password',
                          ),
                          validator: (value) {
                            if (confirmpassController.text !=
                                passwordController.text) {
                              return "Password did not match";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
                        ),
                      ),

                      // role field
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Rool : ",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: primaryColors,
                              ),
                            ),
                            DropdownButton<String>(
                              dropdownColor: Colors.white,
                              isDense: true,
                              isExpanded: false,
                              iconEnabledColor: primaryColors,
                              focusColor: primaryColors,
                              items: options.map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(
                                    dropDownStringItem,
                                    style: TextStyle(
                                      color: primaryColors,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValueSelected) {
                                setState(() {
                                  _currentItemSelected = newValueSelected!;
                                  rool = newValueSelected;
                                });
                              },
                              value: _currentItemSelected,
                            ),
                          ],
                        ),
                      ),

                      // button
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 40),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  CircularProgressIndicator();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 45.0,
                                  decoration: BoxDecoration(
                                    color: primaryColors,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                        12.0,
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  setState(() {
                                    showProgress = true;
                                  });
                                  signUp(
                                    emailController.text,
                                    passwordController.text,
                                    rool,
                                  );
                                },
                                child: Container(
                                  height: 45.0,
                                  decoration: BoxDecoration(
                                    color: primaryColors,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                        12.0,
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Register",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // term & condition
                      Padding(
                        padding: const EdgeInsets.only(top: 60),
                        child: Center(
                          child: Text(
                            'By creating an account, you accept Mahasiswa App',
                          ),
                        ),
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Terms of Service',
                              style: TextStyle(
                                color: primaryColors,
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              'and',
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Privacy Policy',
                              style: TextStyle(
                                color: primaryColors,
                              ),
                            ),
                          ],
                        ),
                      ),
                    
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password, String rool) async {
    CircularProgressIndicator();
    if (_formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore(email, rool)})
          .catchError((e) {});
    }
  }

  postDetailsToFirestore(String email, String rool) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = _auth.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    ref.doc(user!.uid).set({'email': emailController.text, 'rool': rool});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
