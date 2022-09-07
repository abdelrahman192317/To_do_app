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
                'Todo App',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff00dffc),
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10,),
              Expanded(
                child: Container(
                  width: size.width - 22,
                  height: size.height / 1.1,
                  decoration: const BoxDecoration(
                    color: Color(0xff343838),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                  ),
                  padding: EdgeInsets.all(5),
                  child: ListView.separated(
                    padding: const EdgeInsets.only(
                      top: 5,
                    ),
                    itemBuilder: (ct, index) => CardWidget(
                      task: val.list[index],
                    ),
                    itemCount: val.list.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 4,
                      );
                    },
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
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  if(val.p) val.toggleDone();
                },
                icon: const Icon(
                  Icons.list_alt_sharp,
                  color: Color(0xff00dffc),
                  size: 28,
                ),
              ),
              IconButton(
                onPressed: () {
                  if(!val.p) val.toggleDone();
                },
                icon: const Icon(
                  Icons.archive_outlined,
                  color: Color(0xff00dffc),
                  size: 28,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showModalBottomSheet(
              context: context,
              builder: (_) => FormWidget()
          ),
          backgroundColor: Color(0xff008c9e),
          foregroundColor: Color(0xff000000),
          child: const Icon(
            Icons.add,
            size: 36,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}