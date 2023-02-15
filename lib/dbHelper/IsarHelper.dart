
import 'package:get_todo/isarCollections/CourseCollection.dart';
import 'package:get_todo/isarCollections/StudentCollections.dart';
import 'package:get_todo/isarCollections/TeacherCollection.dart';
import 'package:isar/isar.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<void> saveCourse(CourseCollection newCourse) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.courseCollections.putSync(newCourse));
  }

  Future<void> saveStudent(StudentCollections newStudent) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.studentCollections.putSync(newStudent));
  }

  Future<void> saveTeacher(TeacherCollection newTeacher) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.teacherCollections.putSync(newTeacher));
  }

  Future<List<CourseCollection>> getAllCourses() async {
    final isar = await db;
    return await isar.courseCollections.where().findAll();
  }

  Stream<List<CourseCollection>> listenToCourses() async* {
    final isar = await db;
    yield* isar.courseCollections.where().watch(fireImmediately: true);
  }

  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }

  Future<List<StudentCollections>> getStudentsFor(CourseCollection course) async {
    final isar = await db;
    return await isar.studentCollections
        .filter()
        .courses((q) => q.idEqualTo(course.id))
        .findAll();
  }

  Future<TeacherCollection?> getTeacherFor(CourseCollection course) async {
    final isar = await db;

    final teacher = await isar.teacherCollections
        .filter()
        .courses((q) => q.idEqualTo(course.id))
        .findFirst();

    return teacher;
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [CourseCollectionSchema, StudentCollectionsSchema, TeacherCollectionSchema],
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }
}