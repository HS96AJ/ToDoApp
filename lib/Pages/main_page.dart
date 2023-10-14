import 'package:auto_direction/auto_direction.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_app/Components/todo_tile.dart';
import 'package:to_do_app/Data/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box("myBox");
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  void checkBoxChanged(int index) {
    setState(() {
      db.todoList.removeAt(index);
      db.saveData();
    });
  }

  Future _displayBottomSheet(BuildContext context) {
    String textForAutoDirection = "";
    return showModalBottomSheet(
        context: context,
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SizedBox(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: AutoDirection(
                    text: textForAutoDirection,
                    child: TextField(
                      onChanged: (text) {
                        setState(() {
                          textForAutoDirection = text;
                        });
                      },
                      onSubmitted: (value) => {
                        setState(() {
                          db.todoList.add(value);
                          Navigator.pop(context);
                          db.saveData();
                          textForAutoDirection = "Empty";
                        })
                      },
                      decoration: const InputDecoration(
                          hintText: "Add a Task",
                          focusedBorder: InputBorder.none),
                      autofocus: true,
                    ),
                  ),
                ),
              ),
            ));
  }

  void createNewTask() {
    _displayBottomSheet(context);
  }

  @override
  Widget build(BuildContext context) {
    if (db.todoList.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          backgroundColor: Theme.of(context).canvasColor, // Status bar color
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          elevation: 0,
          backgroundColor: Theme.of(context).focusColor,
          child: const Icon(Icons.add),
        ),
        body: const Center(
          child: Text(
            "All tasks are Done!",
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          backgroundColor: Theme.of(context).canvasColor, // Status bar color
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          elevation: 0,
          backgroundColor: Theme.of(context).focusColor,
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ListView.builder(
            itemCount: db.todoList.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                child: ToDoTile(
                    taskName: db.todoList[index],
                    onChanged: (value) => checkBoxChanged(index)),
                onDismissed: (DismissDirection direction) =>
                    checkBoxChanged(index),
              );
            },
          ),
        ),
      );
    }
  }
}
