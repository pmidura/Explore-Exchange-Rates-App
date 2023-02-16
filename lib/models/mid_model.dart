import 'dart:convert';

List<MidModel> midModelFromJson(String str) => List<MidModel>.from(
    json.decode(str).map((x) => MidModel.fromJson(x)));

String midModelToJson(List<MidModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MidModel {
  MidModel({
    required this.no,
    required this.effectiveDate,
    required this.mid,
  });

  String no;
  DateTime effectiveDate;
  double mid;

  factory MidModel.fromJson(Map<String, dynamic> json) => MidModel(
    no: json["no"],
    effectiveDate: DateTime.parse(json["effectiveDate"]),
    mid: json["mid"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "no": no,
    "effectiveDate": "${effectiveDate.year.toString().padLeft(4, '0')}-${effectiveDate.month.toString().padLeft(2, '0')}-${effectiveDate.day.toString().padLeft(2, '0')}",
    "mid": mid,
  };
}
