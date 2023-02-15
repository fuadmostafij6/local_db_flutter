
import 'package:get_todo/isarCollections/StudentCollections.dart';
import 'package:get_todo/isarCollections/TeacherCollection.dart';
import 'package:isar/isar.dart';

part 'CourseCollection.g.dart';

@Collection()
class CourseCollection{
Id id = Isar.autoIncrement;
String? title;

@Backlink(to: "courses")
final teacher = IsarLink<TeacherCollection>();

@Backlink(to: "courses")
final students = IsarLink<StudentCollections>();


}