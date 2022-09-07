import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'toDoList.dart';
import 'task.dart';

class CardWidget extends StatelessWidget {
  final Task task;

  const CardWidget({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    DateTime date = DateTime(task.day.year,task.day.month,task.day.day,task.day.hour,task.day.minute);

    return Slidable(
      child: Card(
        elevation: 8,
        color: Color(0xff00dffc),
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          minLeadingWidth: task.isDone ? 0 : 2,
          leading: Container( width: 2, color: Colors.black,),
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              task.name,
              style: const TextStyle(
                fontSize: 22,
                color: Color(0xff005f6b),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          subtitle: Text(
            task.isDone ? 'Done' :
            DateFormat('EEE, M/d, HH:mm a').format(date),
            style: const TextStyle(
              color: Color(0xff005f6b),
              fontSize: 17,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  Provider.of<ToDoList>(context, listen: false).toggleTask(task);
                },
                icon: Icon(
                  task.isDone? Icons.check_box :
                  Icons.check_box_outline_blank,
                  color: Colors.green,),
              ),
              IconButton(
                onPressed: () {
                  Provider.of<ToDoList>(context,listen: false).deleteFromList(task);
                },
                icon: Icon(Icons.delete,color: Colors.red,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}