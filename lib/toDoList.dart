import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'task.dart';

class ToDoList extends ChangeNotifier {

  List<Task> _tasks = [];

  List<Task> get list {
    _tasks.sort((a,b) => a.day.compareTo(b.day));
    return p? _tasks.where((e) => e.isDone).toList()
        : _tasks.where((e) => !e.isDone).toList();
  }

  getData() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String reJson = pref.getString('myList') ?? '';
    if(reJson != ''){
      List<Task> tasks = Task.decode(reJson);
      _tasks = tasks;
    }
    notifyListeners();
  }

  setData() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String sJson = Task.encode(_tasks);
    pref.setString('myList', sJson);
  }

  int get count {
    return _tasks.length;
  }

  String _name = "task";
  TimeOfDay _time = TimeOfDay(hour: 7,minute: 30);
  DateTime _day = DateTime.now();

  String get name {
    return _name;
  }

  TimeOfDay get time {
    return _time;
  }

  DateTime get day {
    return _day;
  }

  void changeName(String name) {
    this._name = name;
    notifyListeners();
  }

  void changeTime(TimeOfDay time) {
    this.t = true;
    this._day = DateTime(_day.year,_day.month,_day.day,time.hour,time.minute);
    notifyListeners();
  }

  void changeDay(DateTime day) {
    this.d = true;
    this._day = day;
    notifyListeners();
  }

  void addToList(String name, DateTime day) {
    _tasks.add(Task(name: _name, day: _day));
    setData();
    notifyListeners();
  }

  void toggleTask(Task task) {
    task.toggle();
    setData();
    notifyListeners();
  }

  bool p = false;
  bool t = false;
  bool d = false;

  void toggleDone() {
    this.p = !this.p;
    notifyListeners();
  }

  void d2false() {
    this.d = false;
    this.t = false;
    notifyListeners();
  }

  void deleteFromList(Task task) {
    _tasks.remove(task);
    setData();
    notifyListeners();
  }
}