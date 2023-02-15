import 'package:flutter/material.dart';
import 'package:get_todo/Model.dart';
import 'package:get_todo/Services.dart';

import '../dbHelper/HiveDB.dart';

class NewHomePage extends StatefulWidget {
  const NewHomePage({Key? key}) : super(key: key);

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {

  ProductModel ? productModel;

load()async{

  productModel =  await HttpRequest().getProduct();
  await  HiveDb.addNote(productModel!);
}
  @override
  void initState() {
    load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: 
      SingleChildScrollView(
        child: Column(
          children: [

            FutureBuilder<ProductModel?>(
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
                      itemCount: ss.data!.products!.length,
                      itemBuilder: (context, index) {
                        var data = ss.data!.products![index];
                        return Dismissible(
                          onDismissed: (direction) {
                            // HiveDb.deleteNote(data);
                          },
                          key: UniqueKey(),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text(data.name??""),
                                subtitle: Text(""),
                              )),
                        );
                      });
                }),
          ],
        ),
      ),
    );
  }
}
