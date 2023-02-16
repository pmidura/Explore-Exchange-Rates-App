import 'dart:convert';

List<BidAskModel> bidAskModelFromJson(String str) => List<BidAskModel>.from(
    json.decode(str).map((x) => BidAskModel.fromJson(x)));

String bidAskModelToJson(List<BidAskModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BidAskModel {
  BidAskModel({
    required this.no,
    required this.effectiveDate,
    required this.bid,
    required this.ask,
  });

  String no;
  DateTime effectiveDate;
  double bid;
  double ask;

  factory BidAskModel.fromJson(Map<String, dynamic> json) => BidAskModel(
    no: json["no"],
    effectiveDate: DateTime.parse(json["effectiveDate"]),
    bid: json["bid"].toDouble(),
    ask: json["ask"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "no": no,
    "effectiveDate": "${effectiveDate.year.toString().padLeft(4, '0')}-${effectiveDate.month.toString().padLeft(2, '0')}-${effectiveDate.day.toString().padLeft(2, '0')}",
    "bid": bid,
    "ask": ask,
  };
}
