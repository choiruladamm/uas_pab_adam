// ignore_for_file: prefer_const_constructors, unused_local_variable, unnecessary_nullable_for_final_variable_declarations
// ignore_for_file: unused_label
// ignore_for_file: use_build_context_synchronously
// ignore_for_file: prefer_const_declarations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uas_pab_adam/views/utils/pallete.dart';
import 'package:uas_pab_adam/controller/logout.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({Key? key}) : super(key: key);

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  TextEditingController nbiController = TextEditingController();
  TextEditingController mkController = TextEditingController();
  TextEditingController dosenController = TextEditingController();
  TextEditingController presensiController = TextEditingController();
  TextEditingController easController = TextEditingController();
  TextEditingController etsController = TextEditingController();
  TextEditingController predikatController = TextEditingController();

  final CollectionReference _mahasiswa =
      FirebaseFirestore.instance.collection('mahasiswa');

  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    // ignore:
    String action = 'Tambah Nilai';
    if (documentSnapshot != null) {
      action = 'Update Nilai';
      mkController.text = documentSnapshot['nama_mk'];

      dosenController.text = documentSnapshot['dosen'];
      nbiController.text = documentSnapshot['nbi'];
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

      await showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext ctx) {
            SingleChildScrollView:
            true;
            return Padding(
              padding:
                  EdgeInsets.only(top: 30, right: 20, left: 20, bottom: 20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextField(
                    controller: nbiController,
                    decoration: const InputDecoration(labelText: 'NBI'),
                  ),
                  TextField(
                    controller: mkController,
                    decoration: const InputDecoration(labelText: 'Mata Kuliah'),
                  ),
                  TextField(
                    controller: dosenController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Dosen',
                    ),
                    onChanged: (value) => {},
                  ),
                  TextField(
                    controller: presensiController,
                    decoration: const InputDecoration(
                      labelText: 'Presensi',
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
                  TextField(
                    controller: etsController,
                    decoration: const InputDecoration(
                      labelText: 'ETS',
                    ),
                    onChanged: (value) {
                      ets = double.parse(value);
                      setState(() {
                        akhirets = ets / 100 * 40;
                      });
                    },
                  ),
                  TextField(
                    controller: easController,
                    decoration: const InputDecoration(
                      labelText: 'EAS',
                    ),
                    onChanged: (value) {
                      eas = double.parse(value);
                      setState(() {
                        akhireas = eas / 100 * 50;
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
                  TextField(
                    controller: predikatController,
                    decoration: const InputDecoration(
                      labelText: 'Predikat',
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
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: Text('Update Nilai'),
                    onPressed: () async {
                      final String? nama_mk = mkController.text;
                      final String? dosen = dosenController.text;
                      final int? eas = int.tryParse(easController.text);
                      final int? ets = int.tryParse(etsController.text);
                      final String? predikat = predikatController.text;

                      final String? nbi = nbiController.text;

                      final int? presensi = int.parse(presensiController.text);

                      await _mahasiswa.doc(documentSnapshot.id).update({
                        "nama_mk": nama_mk,
                        "dosen": dosen,
                        "eas": eas,
                        "ets": ets,
                        "nbi": nbi,
                        "presensi": presensi,
                        "predikat": predikat,
                      });
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => StudentPage()),
                      );
                    },
                  )
                ],
              ),
            );
          });
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: mkController,
                  decoration: const InputDecoration(labelText: 'Mata Kuliah'),
                ),
                TextField(
                  controller: dosenController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Dosen',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Tambah Nilai'),
                  onPressed: () async {
                    final String? nama_mk = mkController.text;
                    final String? dosen = dosenController.text;
                    final int eas = 0;
                    final int ets = 0;
                    final String nbi = 'nbi';
                    final int presensi = 0;
                    final String predikat = '';

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
                    });

                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> _deleteProduct(String mahasiswaId) async {
    await _mahasiswa.doc(mahasiswaId).delete();

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Delete!')));
  }

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
              'Student Admin',
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
                    height: 270.0,
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
                          SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

                          // button
                          SizedBox(height: 15),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: () {
                                    _createOrUpdate(documentSnapshot);
                                  },
                                  child: Container(
                                    height: 40.0,
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
                                        "Update",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.white,
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
                                    _deleteProduct(documentSnapshot.id);
                                  },
                                  child: Container(
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(
                                          12.0,
                                        ),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Delete",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.white,
                                        ),
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createOrUpdate(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
