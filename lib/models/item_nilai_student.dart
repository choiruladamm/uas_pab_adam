import 'dart:convert';

Item itemFromJson(String str) => Item.fromJson(json.decode(str));

String itemToJson(Item data) => json.encode(data.toJson());

class Item {
    Item({
        required this.id,
        required this.nbi,
        this.namaMk,
        this.dosenId,
        this.presensi,
        this.eas,
        this.ets,
        this.predikat,
    });

    String id;
    String nbi;
    String? namaMk;
    String? dosenId;
    String? presensi;
    String? eas;
    String? ets;
    String? predikat;

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        nbi: json["nbi"],
        namaMk: json["nama_mk"],
        dosenId: json["dosen_id"],
        presensi: json["presensi"],
        eas: json["eas"],
        ets: json["ets"],
        predikat: json["predikat"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nbi": nbi,
        "nama_mk": namaMk,
        "dosen_id": dosenId,
        "presensi": presensi,
        "eas": eas,
        "ets": ets,
        "predikat": predikat,
    };
}
