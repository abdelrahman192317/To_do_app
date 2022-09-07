import 'dart:convert';

class Task {
  final String name;
  final DateTime day;
  bool isDone;
  Task({
    required this.name,
    required this.day,
    this.isDone = false
  });


  void toggle() {
    this.isDone = true;
  }


  factory Task.fromJson(Map<String, dynamic> jsonData) {
    return Task(
        name: jsonData['name'],
        day: jsonData['day'] == null
            ? DateTime.now()
            : DateTime.parse(jsonData['day'] as String),
        isDone: jsonData['isDone'] == null
            ? false :
        jsonData['isDone'] == 'false'
            ? false : true
    );
  }

  static Map<String, dynamic> toMap(Task task) => {
    'name': task.name,
    'day': task.day.toIso8601String(),
    'isDone': task.isDone.toString()
  };

  static String encode(List<Task> listOfTasks) => json.encode(
      listOfTasks.map<Map<String, dynamic>>((task) => Task.toMap(task)).toList()
  );

  static List<Task> decode(String listOfTasks) => (json.decode(
      listOfTasks) as List<dynamic>).map<Task>((item) => Task.fromJson(item))
      .toList();
}