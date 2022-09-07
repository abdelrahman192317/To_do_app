import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'toDoList.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({Key? key}) : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget>{

  @override
  Widget build(BuildContext context){

    Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100)
    );

    Future<TimeOfDay?> pickTime() =>
        showTimePicker(context: context, initialTime: TimeOfDay.now());

    return Consumer<ToDoList> (
      builder: (ctx, val, child) => Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          color: Color(0xff343838),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'New Task',
              textAlign: TextAlign.center,
            ),
            TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Task',
                hintStyle: const TextStyle(
                  color: Color(0xff00dffc),
                ),
              ),
              onChanged: (name) {
                val.changeName(name);
              },
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () async {
                    final date = await pickDate();
                    if (date != null) val.changeDay(date);
                  },
                  icon: Icon(
                    Icons.calendar_today,
                    color: Color(0xff00dffc),
                  ),
                  label: Text(
                    val.d ? DateFormat('EEE, M/d').format(val.day) : 'Time',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () async {
                    final time = await pickTime();
                    if (time != null) val.changeTime(time);
                  },
                  icon: Icon(
                    Icons.access_time_rounded,
                    color: Color(0xff00dffc),
                  ),
                  label: Text(
                    val.t
                        ? TimeOfDay(
                        hour: val.time.hour, minute: val.time.minute)
                        .format(context)
                        : 'Time',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                backgroundColor: Color(0xff2da9ef),
              ),
              onPressed: () {
                val.addToList(val.name, val.day);
                val.d2false();
                Navigator.of(context).pop();
              },
              child: const Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}