import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'homeScreen.dart';
import 'toDoList.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ToDoList(),
    child:MyApp(),
  ));
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Provider.of<ToDoList>(context, listen: false).getData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData.dark(),
      darkTheme: ThemeData(
          primaryColor: Color(0xff343838)
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}