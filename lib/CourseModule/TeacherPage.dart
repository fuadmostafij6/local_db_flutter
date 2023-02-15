

import 'package:flutter/material.dart';
import 'package:get_todo/isarCollections/CourseCollection.dart';
import 'package:get_todo/isarCollections/TeacherCollection.dart';

import '../dbHelper/IsarHelper.dart';
class TeacherPage extends StatefulWidget {
  final IsarService service;

  const TeacherPage(this.service, {Key? key}) : super(key: key);

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  CourseCollection? selectedCourse;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Give your new teacher a name",
                style: Theme.of(context).textTheme.headlineSmall),
            TextFormField(
              controller: _textController,
              autofocus: true,
              validator: (value) {
                if (value == null || value.isEmpty)
                  return "Teacher Name is not allowed to be empty";
                return null;
              },
            ),
            FutureBuilder<List<CourseCollection>>(
              future: widget.service.getAllCourses(),
              builder: (context, AsyncSnapshot<List<CourseCollection>> snapshot) {
                if (snapshot.hasData) {
                  List<CourseCollection> data = snapshot.data!;
                  selectedCourse = data.first;
                  final courses = data.map((course) {
                    return DropdownMenuItem<CourseCollection>(
                        value: course, child: Text(course.title!));
                  }).toList();

                  return DropdownButtonFormField<CourseCollection>(
                      items: courses,
                      value: selectedCourse,
                      onChanged: (course) => selectedCourse = course);
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print(selectedCourse!.id);
                    widget.service.saveTeacher(
                      TeacherCollection()
                        ..name = _textController.text
                        ..courses.value = selectedCourse,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "New teacher '${_textController.text}' saved in DB")));

                    Navigator.pop(context);
                  }
                },
                child: const Text("Add new teacher"))
          ],
        ),
      ),
    );
  }
}