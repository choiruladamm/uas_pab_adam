// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, unused_field, unused_local_variable, constant_identifier_names,no_leading_underscores_for_local_identifiers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uas_pab_adam/models/item_nilai_student.dart';
import 'package:uas_pab_adam/views/login.dart';
import 'package:uas_pab_adam/views/utils/custom_form_field.dart';
import 'package:uas_pab_adam/views/utils/pallete.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const DATA_NILAI_STUDENT = 'nilai_student';

class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  List<Item> nilaiStudent = [];

  @override
  void initState() {
    fetchRecord();
    FirebaseFirestore.instance
        .collection(DATA_NILAI_STUDENT)
        .snapshots()
        .listen(
      (records) {
        mapRecords(records);
      },
    );
    super.initState();
  }

  // fetch data dari collection firebare
  fetchRecord() async {
    var records =
        await FirebaseFirestore.instance.collection(DATA_NILAI_STUDENT).get();
    mapRecords(records);
  }

  // convert data ke list
  mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
    var _list = records.docs
        .map(
          (item) => Item(
            id: item.id,
            nbi: item['nbi'],
            namaMk: item['nama_mk'],
            dosenId: item['dosen_id'],
            presensi: item['presensi'],
            eas: item['eas'],
            ets: item['ets'],
            predikat: item['predikat'],
          ),
        )
        .toList();

    setState(() {
      nilaiStudent = _list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                    'Student Admin',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // content
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  mainAxisExtent: 500,
                ),
                itemCount: nilaiStudent.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x19000000),
                          blurRadius: 24,
                          offset: Offset(0, 11),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Nbi",
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            alignment: Alignment.center,
                            height: 25,
                            decoration: BoxDecoration(
                              color: primaryColors,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Text(
                              nilaiStudent[index].nbi,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Mata Kuliah",
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            alignment: Alignment.center,
                            height: 25,
                            decoration: BoxDecoration(
                              color: primaryColors,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Text(
                              nilaiStudent[index].namaMk ?? '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Nama Dosen",
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            alignment: Alignment.center,
                            height: 25,
                            decoration: BoxDecoration(
                              color: primaryColors,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Text(
                              nilaiStudent[index].dosenId ?? '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Presensi",
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            alignment: Alignment.center,
                            height: 25,
                            decoration: BoxDecoration(
                              color: primaryColors,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Text(
                              nilaiStudent[index].presensi.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Eas",
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            alignment: Alignment.center,
                            height: 25,
                            decoration: BoxDecoration(
                              color: primaryColors,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Text(
                              nilaiStudent[index].eas.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Ets",
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            alignment: Alignment.center,
                            height: 25,
                            decoration: BoxDecoration(
                              color: primaryColors,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Text(
                              nilaiStudent[index].ets.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Predikat",
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            alignment: Alignment.center,
                            height: 25,
                            decoration: BoxDecoration(
                              color: primaryColors,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Text(
                              nilaiStudent[index].predikat.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  deteleItem(nilaiStudent[index].id);
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    backgroundColor:
                                        Colors.red, // <-- Button color
                                    foregroundColor:
                                        Colors.grey[800], // <-- Splash color
                                    ),
                                child: Icon(Icons.delete, color: Colors.white),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // showItemDialogUpdate();
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    backgroundColor:
                                        primaryColors, // <-- Button color
                                    foregroundColor:
                                        Colors.grey[800], // <-- Splash color
                                    ),
                                child: Icon(Icons.edit, color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          
          ],
        ),
      ),
      // button create data
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCreateItemDialog();
        },
        backgroundColor: primaryColors,
        child: const Icon(Icons.add),
      ),
    );
  }

  // method logout
  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  // show dialog create data
  showCreateItemDialog() {
    var nbiController = TextEditingController();
    var matkulController = TextEditingController();
    var dosenController = TextEditingController();
    var presensiController = TextEditingController();
    var easController = TextEditingController();
    var etsController = TextEditingController();
    var predikatController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  CustomFormField(
                    keyboardType: TextInputType.name,
                    hintName: "Nbi",
                    controller: nbiController,
                  ),
                  SizedBox(height: 10),
                  CustomFormField(
                    keyboardType: TextInputType.name,
                    hintName: "Mata Kuliah",
                    controller: matkulController,
                  ),
                  SizedBox(height: 10),
                  CustomFormField(
                    keyboardType: TextInputType.name,
                    hintName: "Nama Dosen",
                    controller: dosenController,
                  ),
                  SizedBox(height: 10),
                  CustomFormField(
                    keyboardType: TextInputType.number,
                    hintName: "Presensi",
                    controller: presensiController,
                  ),
                  SizedBox(height: 10),
                  CustomFormField(
                    keyboardType: TextInputType.number,
                    hintName: "Nilai Eas",
                    controller: easController,
                  ),
                  SizedBox(height: 10),
                  CustomFormField(
                    keyboardType: TextInputType.number,
                    hintName: "Nilai Ets",
                    controller: etsController,
                  ),
                  SizedBox(height: 10),
                  CustomFormField(
                    keyboardType: TextInputType.name,
                    hintName: "Predikat",
                    controller: predikatController,
                  ),
                  SizedBox(height: 30),
                  InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      var nbiField = nbiController.text.trim();
                      var matkulField = matkulController.text.trim();
                      var dosenField = dosenController.text.trim();
                      var presensiField = presensiController.text.trim();
                      var easField = easController.text.trim();
                      var etsField = etsController.text.trim();
                      var predikatField = predikatController.text.trim();
                      addItem(nbiField, matkulField, dosenField, presensiField,
                          easField, etsField, predikatField);
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
                          "Add",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
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

  // create data
  addItem(String nbi, String namaMk, String dosenId, String presensi,
      String eas, String ets, String predikat) {
    var item = Item(
      id: 'id',
      nbi: nbi,
      namaMk: namaMk,
      dosenId: dosenId,
      presensi: '0',
      eas: '0',
      ets: '0',
      predikat: 'E',
    );
    FirebaseFirestore.instance.collection(DATA_NILAI_STUDENT).add(item.toJson());
  }

  // detele data
  deteleItem(String id){
    FirebaseFirestore.instance.collection(DATA_NILAI_STUDENT).doc(id).delete();
  }

}
