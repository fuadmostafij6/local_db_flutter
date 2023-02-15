
import 'package:flutter/material.dart';
import 'package:get_todo/CourseModule/StudentPage.dart';
import 'package:get_todo/CourseModule/TeacherPage.dart';
import 'package:get_todo/isarCollections/CourseCollection.dart';

import '../dbHelper/IsarHelper.dart';
import 'CourseDetailsPage.dart';
import 'CoursesPage.dart';
class DataAddPage extends StatelessWidget {
  DataAddPage({Key? key}) : super(key: key);
  final service = IsarService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Isar DB Tutorial'), actions: [
        IconButton(
          onPressed: () => service.cleanDb(),
          icon: const Icon(Icons.delete),
        )
      ]),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<List<CourseCollection>>(
                stream: service.listenToCourses(),
                builder: (context, snapshot) => GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  scrollDirection: Axis.horizontal,
                  children: snapshot.hasData
                      ? snapshot.data!.map((course) {
                    return ElevatedButton(
                      onPressed: () {
                        CourseDetailPage.navigate(context, course, service);
                      },
                      child: Text(course.title!),
                    );
                  }).toList()
                      : [],
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return CoursePage(service);
                  });
            },
            child: const Text("Add Course"),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return StudentPage(service);
                  });
            },
            child: const Text("Add Student"),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return TeacherPage(service);
                  });
            },
            child: const Text("Add Teacher"),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}