
import 'package:get_todo/Model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../Model/hiveNote.dart';



class HiveDb{
 static Future init()async{
  await  Hive.initFlutter();
  await Hive.openBox("product");
  }
  static final box = Hive.box("product");

 static Future<int> addNote(ProductModel hiveNoteModel) async {


  return box.add(hiveNoteModel.toJson());



 }

 // static Future<void> updateNote(HiveNoteModel hiveNoteModel) async {
 //
 //
 //
 //
 //  return box.put(hiveNoteModel.key, hiveNoteModel.toJson());
 // }
 //
 // static Future<void> deleteNote(HiveNoteModel hiveNoteModel) async {
 //
 //
 //
 //  return box.delete(hiveNoteModel.key);
 // }

 static Future<ProductModel?> getAllNote() async {
   ProductModel? productModel;


  final  maps =  box.keys.map((key) {
   Map<dynamic, dynamic> item = box.get(key);
   print(item);
   productModel = ProductModel.fromJson(item);

  }).toList();

  if (maps.isEmpty) {
   return null;
  } else {



   return productModel;

  }
 }

}