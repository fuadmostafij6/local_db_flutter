

import 'package:get_todo/isarCollections/CourseCollection.dart';
import 'package:isar/isar.dart';

part 'StudentCollections.g.dart';

@Collection()
class StudentCollections{
  Id id = Isar.autoIncrement;
  String? name;
  final courses = IsarLinks<CourseCollection>();
}