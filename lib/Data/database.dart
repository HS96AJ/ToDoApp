import 'package:hive_flutter/adapters.dart';

class ToDoDatabase {
  List todoList = [];
  final _myBox = Hive.box("myBox");

  void createInitialData(){
    todoList = ["Swipe to Dismiss"];
  }

  void loadData(){
    todoList = _myBox.get("TODOLIST");
  }

  void saveData(){
    _myBox.put("TODOLIST", todoList);
  }
}