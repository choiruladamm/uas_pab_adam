// ignore_for_file: prefer_const_constructors, unused_local_variable, unnecessary_nullable_for_final_variable_declarations
// ignore_for_file: unused_label
// ignore_for_file: use_build_context_synchronously
// ignore_for_file: prefer_const_declarations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uas_pab_adam/views/utils/pallete.dart';
import 'package:uas_pab_adam/controller/logout.dart';

class TeacherPage extends StatefulWidget {
  const TeacherPage({Key? key}) : super(key: key);

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {

  final CollectionReference _mahasiswa =
      FirebaseFirestore.instance.collection('mahasiswa');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // custom app bar
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
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
              'Teacher User',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),

      body: StreamBuilder(
        stream: _mahasiswa.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Padding(
                  padding: EdgeInsets.only(left: 18, right: 18, top: 20),
                  child: Container(
                    height: 250.0,
                    decoration: BoxDecoration(
                      color: primaryColorsBackground,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            documentSnapshot['nama_mk'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: primaryColors,
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "NIM",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: primaryColors,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Dosen",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: primaryColors,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Presensi",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: primaryColors,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Nilai EAS",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: primaryColors,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Nilai ETS",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: primaryColors,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Predikat",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: primaryColors,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    documentSnapshot['nbi'],
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: primaryColors,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    documentSnapshot['dosen'],
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: primaryColors,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    documentSnapshot['presensi'].toString(),
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: primaryColors,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    documentSnapshot['eas'].toString(),
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: primaryColors,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    documentSnapshot['ets'].toString(),
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: primaryColors,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    documentSnapshot['predikat'].toString(),
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: primaryColors,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

}
