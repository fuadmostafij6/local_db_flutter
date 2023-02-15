
import 'package:hive_flutter/hive_flutter.dart';

import '../Model/hiveNote.dart';



class HiveDb{
 static Future init()async{
  await  Hive.initFlutter();
  await Hive.openBox("hive");
  }
  static final box = Hive.box("hive");

 static Future<int> addNote(HiveNoteModel hiveNoteModel) async {


  return box.add(hiveNoteModel.toJson());



 }

 static Future<void> updateNote(HiveNoteModel hiveNoteModel) async {




  return box.put(hiveNoteModel.key, hiveNoteModel.toJson());
 }

 static Future<void> deleteNote(HiveNoteModel hiveNoteModel) async {



  return box.delete(hiveNoteModel.key);
 }

 static Future<List<HiveNoteModel>?> getAllNote() async {
   List<HiveNoteModel>? data =[];
  final  maps =  box.keys.map((key) {
   final item = box.get(key);
   HiveNoteModel hiveNoteModel =HiveNoteModel(
       key: key,
       title: item["title"],
       descrtiption: item["descrtiption"]
   );
   data.add(hiveNoteModel);

  }).toList();

  if (maps.isEmpty) {
   return null;
  } else {



   return data;

  }
 }

}