import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'form.dart';

import 'toDoList.dart';
import 'card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Consumer<ToDoList>(
      builder: (ctx, val, child) => Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
              color: Color(0xff005f6b)
          ),
          child: Column(
            children: [
              SizedBox(height: 10,),
              Text(
                val.p == true ? 'Archived' : 'Todo List',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10,),
              Expanded(
                child: Container(
                  width: size.width - 22,
                  height: size.height / 1.1,
                  decoration: BoxDecoration(
                    color: Color(0xff343838),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemBuilder: (ct, index) => CardWidget(
                      task: val.list[index],
                    ),
                    itemCount: val.list.length,
                  ),
                ),
              ),
            ],
          ),
          padding: EdgeInsets.only(top: 20),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 8,
          color: Color(0xff000000),
          shape: CircularNotchedRectangle(),
          notchMargin: 8,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  if(val.p) val.toggleDone();
                },
                icon: Icon(
                  Icons.list_alt_sharp,
                  color: val.p == true ? Colors.grey : Color(0xff00dffc),
                  size: 28,
                ),
              ),
              IconButton(
                onPressed: () {
                  if(!val.p) val.toggleDone();
                },
                icon: Icon(
                  Icons.archive_outlined,
                  color: val.p == false ? Colors.grey : Color(0xff00dffc),
                  size: 28,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showDialog(
              context: context,
              builder: (_) => FormWidget()
          ),
          backgroundColor: Color(0xff008c9e),
          foregroundColor: Color(0xff000000),
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}