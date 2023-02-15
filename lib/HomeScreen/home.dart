import 'package:flutter/material.dart';
import 'package:get_todo/Model/hiveNote.dart';
import 'package:get_todo/dbHelper/HiveDB.dart';

import '../Model/Note.dart';
import '../dbHelper/dbHelper.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Note"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          HiveNoteModel noteModel = HiveNoteModel(title: "title", descrtiption: "desc");
          HiveDb.addNote(noteModel);
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FutureBuilder<List<HiveNoteModel>?>(
              future: HiveDb.getAllNote(),
              builder: (context, ss) {
                if (ss.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (!ss.hasData) {
                  return Center(
                    child: Text("There is no data"),
                  );
                }

                return ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: ss.data!.length,
                    itemBuilder: (context, index) {
                      var data = ss.data![index];
                      return Dismissible(
                        onDismissed: (direction) {
                          HiveDb.deleteNote(data);
                        },
                        key: UniqueKey(),
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(data.key!.toString()),
                              subtitle: Text(data.descrtiption!),
                            )),
                      );
                    });
              }),
        ],
      ),
    );
  }
}
