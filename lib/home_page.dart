import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_hive/hive_database/database.dart';
import 'package:todo_hive/utils/todo_container.dart';
import 'package:todo_hive/widgets/common_button.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  // final _hiveBox = Hive.box("myBox");
  final TextEditingController todoController = TextEditingController();
  HiveDatabase db = HiveDatabase();

  @override
  void initState() {
    super.initState();
    openHiveBox();
  }

  Future<void> openHiveBox() async {
    await Hive.openBox("myBox");
    db.loadData();
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[200],
      appBar: AppBar(
        centerTitle: true,
        title: Text("TODO APP USING HIVE"),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            onPressed:(p0) {
              setState(() {
                db.todoList.removeAt(index);
              });
              db.updateData();

            },
            onChanged: (p0) {
              setState(() {

                db.todoList[index][1] = !db.todoList[index][1];

              });
              db.updateData();
            },
            taskCompleted: db.todoList[index][1],
            taskName: db.todoList[index][0],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: AlertDialog(
                  backgroundColor: Colors.purple,
                  content: Container(
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextField(
                          controller: todoController,
                          decoration: InputDecoration(
                              hintText: "Write Todo Things",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.black))),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CommonButton(
                              text: "Save",
                              onPressed: () {
                                setState(() {
                                  db.todoList.add([todoController.text, false]);

                                  todoController.clear();
                                });
                                db.updateData();
                                Navigator.pop(context);
                              },
                            ),
                            CommonButton(
                              text: "Cancel",
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
