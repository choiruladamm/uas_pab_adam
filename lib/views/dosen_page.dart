// ignore_for_file: prefer_const_constructors, unused_local_variable, unnecessary_nullable_for_final_variable_declarations
// ignore_for_file: unused_label
// ignore_for_file: use_build_context_synchronously
// ignore_for_file: prefer_const_declarations
// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uas_pab_adam/views/utils/pallete.dart';
import 'package:uas_pab_adam/controller/logout_controller.dart';

const DATA_NILAI_MAHASISWA = 'data_mahasiswa';

class DosenPage extends StatefulWidget {
  const DosenPage({Key? key}) : super(key: key);

  @override
  State<DosenPage> createState() => _DosenPageState();
}

class _DosenPageState extends State<DosenPage> {
  final CollectionReference _mahasiswa =
      FirebaseFirestore.instance.collection(DATA_NILAI_MAHASISWA);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      // custom app bar
      appBar: AppBar(
        centerTitle: true,
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
              'Dosen User',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),

      // load data dari firebase collection data_mahasiswa
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
                  padding: EdgeInsets.only(left: 18, right: 18, top: 20, bottom: 20),
                  child: Container(
                    height: 350.0,
                    decoration: BoxDecoration(
                      color: primaryColorsBackground,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          // matkul widget
                          Container(
                            alignment: Alignment.centerLeft,
                            width: size.width,
                            decoration: const BoxDecoration(
                              color: primaryColors,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                            ),
                            height: 40,
                            child: Center(
                              child: Text(
                                documentSnapshot['nama_mk'],
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),

                          // nbi widget
                          Container(
                            alignment: Alignment.centerLeft,
                            width: size.width,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.data_usage_outlined),
                                    SizedBox(width: 15),
                                    Text(
                                      'Nbi',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  documentSnapshot['nbi'],
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // nama dosen widget
                          Container(
                            alignment: Alignment.centerLeft,
                            width: size.width,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.data_usage_outlined),
                                    SizedBox(width: 15),
                                    Text(
                                      'Nama Dosen',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  documentSnapshot['dosen'],
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // nilai presensi widget
                          Container(
                            alignment: Alignment.centerLeft,
                            width: size.width,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.data_usage_outlined),
                                    SizedBox(width: 15),
                                    Text(
                                      'Nilai Presensi',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  documentSnapshot['presensi'].toString(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // nilai ets widget
                          Container(
                            alignment: Alignment.centerLeft,
                            width: size.width,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.data_usage_outlined),
                                    SizedBox(width: 15),
                                    Text(
                                      'Nilai Ets',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  documentSnapshot['ets'].toString(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // nilai eas widget
                          Container(
                            alignment: Alignment.centerLeft,
                            width: size.width,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.data_usage_outlined),
                                    SizedBox(width: 15),
                                    Text(
                                      'Nilai Eas',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  documentSnapshot['eas'].toString(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // nilai predikat widget
                          Container(
                            alignment: Alignment.centerLeft,
                            width: size.width,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.data_usage_outlined),
                                    SizedBox(width: 15),
                                    Text(
                                      'Nilai Predikat Akhir',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  documentSnapshot['predikat'],
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
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
