// ignore_for_file: prefer_const_constructors, unused_local_variable, unnecessary_nullable_for_final_variable_declarations
// ignore_for_file: unused_label
// ignore_for_file: use_build_context_synchronously
// ignore_for_file: prefer_const_declarations
// ignore_for_file: unused_element
// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uas_pab_adam/views/utils/custom_form_field.dart';
import 'package:uas_pab_adam/views/utils/pallete.dart';
import 'package:uas_pab_adam/controller/logout_controller.dart';

const DATA_NILAI_MAHASISWA = 'data_mahasiswa';

class MahasiswaPage extends StatefulWidget {
  const MahasiswaPage({Key? key}) : super(key: key);

  @override
  State<MahasiswaPage> createState() => _MahasiswaPageState();
}

class _MahasiswaPageState extends State<MahasiswaPage> {
  TextEditingController nbiController = TextEditingController();
  TextEditingController mkController = TextEditingController();
  TextEditingController dosenController = TextEditingController();
  TextEditingController presensiController = TextEditingController();
  TextEditingController easController = TextEditingController();
  TextEditingController etsController = TextEditingController();
  TextEditingController predikatController = TextEditingController();

  final CollectionReference _mahasiswa =
      FirebaseFirestore.instance.collection(DATA_NILAI_MAHASISWA);

  Future<void> updateData([DocumentSnapshot? documentSnapshot]) async {
    String action = 'Add Data';
    if (documentSnapshot != null) {
      action = 'Update Data';

      nbiController.text = documentSnapshot['nbi'];
      mkController.text = documentSnapshot['nama_mk'];
      dosenController.text = documentSnapshot['dosen'];
      presensiController.text = documentSnapshot['presensi'].toString();
      easController.text = documentSnapshot['eas'].toString();
      etsController.text = documentSnapshot['ets'].toString();
      predikatController.text = documentSnapshot['predikat'].toString();

      double eas = 0;
      double ets = 0;
      double presensi;
      double akhirets = 0;
      double akhireas = 0;
      double akhirpresensi = 0;
      String predikat;

      // show doalog update data Mahasiswa
      await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return Dialog(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    CustomFormField(
                      controller: nbiController,
                      hintName: 'Input Nbi',
                    ),
                    SizedBox(height: 10),
                    CustomFormField(
                      controller: mkController,
                      hintName: 'Input Mata Kuliah',
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: dosenController,
                      style: TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        hintText: 'Nama Dosen',
                        filled: true,
                        fillColor: primaryColorsBackground,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.only(top: 10, left: 20),
                      ),
                      onChanged: (value) => {},
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: presensiController,
                      style: TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        hintText: 'Presensi',
                        filled: true,
                        fillColor: primaryColorsBackground,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.only(top: 10, left: 20),
                      ),
                      onChanged: (value) {
                        presensi = double.parse(value);
                        setState(
                          () {
                            akhirpresensi = presensi / 16 * 10;
                          },
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: etsController,
                      style: TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        hintText: 'Input Nilai Ets',
                        filled: true,
                        fillColor: primaryColorsBackground,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.only(top: 10, left: 20),
                      ),
                      onChanged: (value) {
                        ets = double.parse(value);
                        setState(() {
                          akhirets = ets / 100 * 40;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: easController,
                      style: TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        hintText: 'Input Nilai Eas',
                        filled: true,
                        fillColor: primaryColorsBackground,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.only(top: 10, left: 20),
                      ),
                      onChanged: (value) {
                        eas = double.parse(value);
                        setState(() {
                          akhireas = eas / 100 * 50;
                          // ignore: non_constant_identifier_names
                          double NA = akhirets + akhireas + akhirpresensi;
                          if (NA <= 45) {
                            predikatController.text = 'D';
                          } else if (NA <= 50) {
                            predikatController.text = 'D+';
                          } else if (NA <= 55) {
                            predikatController.text = 'C-';
                          } else if (NA <= 60) {
                            predikatController.text = 'C';
                          } else if (NA <= 65) {
                            predikatController.text = 'C+';
                          } else if (NA <= 70) {
                            predikatController.text = 'B-';
                          } else if (NA <= 75) {
                            predikatController.text = 'B';
                          } else if (NA <= 80) {
                            predikatController.text = 'B+';
                          } else if (NA <= 85) {
                            predikatController.text = 'A-';
                          } else if (NA <= 100) {
                            predikatController.text = 'A';
                          }
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: predikatController,
                      style: TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        hintText: 'Predikat',
                        filled: true,
                        fillColor: primaryColorsBackground,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.only(top: 10, left: 20),
                      ),
                      onChanged: (value) {
                        predikat = value;
                        setState(() {
                          double NA = akhirets + akhireas + akhirpresensi;
                          if (NA <= 45) {
                            predikatController.text = 'D';
                          } else if (NA <= 50) {
                            predikatController.text = 'D+';
                          } else if (NA <= 55) {
                            predikatController.text = 'C-';
                          } else if (NA <= 60) {
                            predikatController.text = 'C';
                          } else if (NA <= 65) {
                            predikatController.text = 'C+';
                          } else if (NA <= 70) {
                            predikatController.text = 'B-';
                          } else if (NA <= 75) {
                            predikatController.text = 'B';
                          } else if (NA <= 80) {
                            predikatController.text = 'B+';
                          } else if (NA <= 85) {
                            predikatController.text = 'A-';
                          } else if (NA <= 100) {
                            predikatController.text = 'A';
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () async {
                        final String? nama_mk = mkController.text;
                        final String? dosen = dosenController.text;
                        final int? eas = int.tryParse(easController.text);
                        final int? ets = int.tryParse(etsController.text);
                        final String? predikat = predikatController.text;

                        final String? nbi = nbiController.text;

                        final int? presensi =
                            int.parse(presensiController.text);

                        await _mahasiswa.doc(documentSnapshot.id).update({
                          "nama_mk": nama_mk,
                          "dosen": dosen,
                          "eas": eas,
                          "ets": ets,
                          "nbi": nbi,
                          "presensi": presensi,
                          "predikat": predikat,
                        });
                        Navigator.pop(context);
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
                            "Update Data",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
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
  }

  // method delete data mahasiswa
  Future<void> deleteData(String mahasiswaId) async {
    await _mahasiswa.doc(mahasiswaId).delete();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(milliseconds: 300),
        content: Text('Hapus Berhasil'),
      ),
    );
  }

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
              'Mahasiswa Admin',
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
                  padding: EdgeInsets.only(left: 18, right: 18, top: 20, bottom: 20),
                  child: Container(
                    height: 390.0,
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

                          // button update delete
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      deleteData(documentSnapshot.id);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: CircleBorder(),
                                        padding: EdgeInsets.all(10),
                                        backgroundColor: Colors.red),
                                    child:
                                        Icon(Icons.delete, color: Colors.white),
                                  ),
                                  Text(
                                    "Delete",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      updateData(documentSnapshot);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: CircleBorder(),
                                        padding: EdgeInsets.all(10),
                                        backgroundColor: primaryColors),
                                    child:
                                        Icon(Icons.edit, color: Colors.white),
                                  ),
                                  Text(
                                    "Update",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        
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

      // create data
      floatingActionButton: FloatingActionButton(
        onPressed: () => showCreateItemDialog(),
        backgroundColor: primaryColors,
        child: Icon(Icons.add),
      ),
    );
  }

  // method create data Mahasiswa
  showCreateItemDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFormField(
                        controller: mkController,
                        hintName: 'Input Mata Kuliah',
                      ),
                      SizedBox(height: 15),
                      CustomFormField(
                        controller: dosenController,
                        hintName: 'Input Nama Dosen',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () async {
                          final String? nama_mk = mkController.text;
                          final String? dosen = dosenController.text;
                          final int eas = 0;
                          final int ets = 0;
                          final String nbi = 'nbi';
                          final int presensi = 0;
                          final String predikat = '';
                          final DateTime timestamp = DateTime.now();

                          mkController.text = '';
                          dosenController.text = '';

                          await _mahasiswa.add({
                            "nama_mk": nama_mk,
                            "dosen": dosen,
                            "eas": eas,
                            "ets": ets,
                            "nbi": nbi,
                            "presensi": presensi,
                            "predikat": predikat,
                            "timestamp": timestamp,
                          });

                          Navigator.of(context).pop();
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
                              "Add Data",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
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
}
