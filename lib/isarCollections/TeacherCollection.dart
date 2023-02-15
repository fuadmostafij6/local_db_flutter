

import 'package:isar/isar.dart';

import 'CourseCollection.dart';

part 'TeacherCollection.g.dart';
@Collection()
class TeacherCollection{
  Id id = Isar.autoIncrement;
  String? name;
  final courses = IsarLink<CourseCollection>();
}