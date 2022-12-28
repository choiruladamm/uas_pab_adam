// import 'dart:convert';

// StudentModel studentModelFromJson(String str) => StudentModel.fromJson(json.decode(str));

// String studentModelToJson(StudentModel data) => json.encode(data.toJson());

// class StudentModel {
//     StudentModel({
//         this.id,
//         required this.nbi,
//         required this.namaMk,
//         required this.dosenId,
//         required this.presensi,
//         required this.eas,
//         required this.ets,
//         required this.predikat,
//     });

//     String? id;
//     final String nbi;
//     final String namaMk;
//     final String dosenId;
//     final int presensi;
//     final int eas;
//     final int ets;
//     final String predikat;

//     factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
//         id: json["id"],
//         nbi: json["nbi"],
//         namaMk: json["nama_mk"],
//         dosenId: json["dosen_id"],
//         presensi: json["presensi"],
//         eas: json["eas"],
//         ets: json["ets"],
//         predikat: json["predikat"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "nbi": nbi,
//         "nama_mk": namaMk,
//         "dosen_id": dosenId,
//         "presensi": presensi,
//         "eas": eas,
//         "ets": ets,
//         "predikat": predikat,
//     };
// }
