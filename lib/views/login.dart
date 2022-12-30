// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uas_pab_adam/views/register.dart';
import 'package:uas_pab_adam/views/student.dart';
import 'package:uas_pab_adam/views/teacher.dart';
import 'package:uas_pab_adam/views/utils/pallete.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure3 = true;
  bool visible = false;

  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;

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
                          onSaved: (value) {
                            emailController.text = value!;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),

                      // pasword field
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 20, left: 20, top: 15),
                        child: TextFormField(
                          obscureText: _isObscure3,
                          controller: passwordController,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: primaryColorsBackground,
                            suffixIcon: IconButton(
                              icon: Icon(_isObscure3
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isObscure3 = !_isObscure3;
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
                            RegExp regex = RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return "Password cannot be empty";
                            }
                            if (!regex.hasMatch(value)) {
                              return ("please enter valid password min. 6 character");
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            passwordController.text = value!;
                          },
                        ),
                      ),

                      // button login
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 50),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            setState(() {
                              visible = true;
                            });
                            signIn(
                                emailController.text, passwordController.text);
                          },
                          child: Container(
                            height: 50.0,
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

                      Visibility(
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        visible: visible,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: primaryColors,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // another login
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Dont have an account?',
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Register here',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColors,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20),
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
        ),
      ),
    );
  }

  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('rool') == "Teacher") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => TeacherPage(),
            ),
          );
        } else if (documentSnapshot.get('rool') == "Student") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => StudentPage(),
            ),
          );
        }
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        route();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }
  }
}
