
// To parse this JSON data, do
//
//     final noteModel = noteModelFromJson(jsonString);

import 'dart:convert';

List<NoteModel> noteModelFromJson(String str) => List<NoteModel>.from(json.decode(str).map((x) => NoteModel.fromJson(x)));

String noteModelToJson(List<NoteModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NoteModel {
  NoteModel({
    this.id,
    this.title,
    this.description,
  });

  int? id;
  String? title;
  String? description;

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
    id: json["id"],
    title: json["title"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
  };
}
