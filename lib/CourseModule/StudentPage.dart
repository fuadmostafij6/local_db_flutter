



import 'package:get_todo/isarCollections/CourseCollection.dart';
import 'package:get_todo/isarCollections/StudentCollections.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../dbHelper/IsarHelper.dart';
import 'package:flutter/material.dart';
class StudentPage extends StatefulWidget {
  final IsarService service;

  const StudentPage(this.service, {Key? key}) : super(key: key);

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  List<CourseCollection> selectedCourses = [];

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
            Text("Give your new student a name",
                style: Theme.of(context).textTheme.headlineSmall),
            TextFormField(
              controller: _textController,
              autofocus: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Student Name is not allowed to be empty";
                }
                return null;
              },
            ),
            FutureBuilder<List<CourseCollection>>(
              future: widget.service.getAllCourses(),
              builder: (context, AsyncSnapshot<List<CourseCollection>> snapshot) {
                if (snapshot.hasData) {
                  final courses = snapshot.data!.map((course) {
                    return MultiSelectItem<CourseCollection>(course, course.title!);
                  }).toList();

                  return MultiSelectDialogField<CourseCollection>(
                      items: courses,
                      onConfirm: (value) {
                        selectedCourses = value;
                      });
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
            ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    widget.service.saveStudent(
                      StudentCollections()
                        ..name = _textController.text
                        ..courses.addAll(selectedCourses),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              "New student '${_textController.text}' saved in DB")),
                    );

                    Navigator.pop(context);
                  }
                },
                child: const Text("Add new student"))
          ],
        ),
      ),
    );
  }
}