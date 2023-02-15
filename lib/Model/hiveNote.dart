// To parse this JSON data, do
//
//     final hiveNoteModel = hiveNoteModelFromJson(jsonString);

import 'dart:convert';

List<HiveNoteModel> hiveNoteModelFromJson(String str) => List<HiveNoteModel>.from(json.decode(str).map((x) => HiveNoteModel.fromJson(x)));

String hiveNoteModelToJson(List<HiveNoteModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HiveNoteModel {
  HiveNoteModel({
    this.key,
    this.title,
    this.descrtiption,
  });

  dynamic key;
  String? title;
  String? descrtiption;

  factory HiveNoteModel.fromJson(Map<String, dynamic> json) => HiveNoteModel(
    key: json["key"],
    title: json["title"],
    descrtiption: json["descrtiption"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "title": title,
    "descrtiption": descrtiption,
  };
}
