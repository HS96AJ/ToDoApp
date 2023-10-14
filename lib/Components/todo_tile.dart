import 'package:auto_direction/auto_direction.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ToDoTile extends StatelessWidget {
  final String taskName;

  ToDoTile(
      {super.key,
      required this.taskName,
      required this.onChanged});

  void Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Theme.of(context).focusColor),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 25, right: 20, top:20, bottom: 20),
          child: Row(
            children: [
              Expanded(
                child: AutoDirection(
                  text: taskName,
                  child: Text(
                    taskName,
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
