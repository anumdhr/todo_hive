import 'package:hive_flutter/hive_flutter.dart';

class HiveDatabase {
  List<dynamic> todoList = [];
  final _myBox = Hive.box("myBox");

  void loadData(){
    todoList = _myBox.get("TODOLIST");
  }

  void updateData(){
    _myBox.put("TODOLIST", todoList);
  }
}
