import 'package:flutter/material.dart';
import 'package:todo/modules/settings/settings.dart';
import 'package:todo/modules/tasks_list/tasks_list.dart';
import 'add_task_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        toolbarHeight: MediaQuery.of(context).size.height * 0.2,
        title: Text("Route Tasks"),
      ),
      body: tabs[currentIndex],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.list,
                  size: 30,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                  size: 30,
                ),
                label: ""),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(side: BorderSide(color: Colors.white, width: 2)),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          showAddTaskBottomSheet(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  List<Widget> tabs = [
    TasksListTab(),
    SettingsTab(),
  ];
}

void showAddTaskBottomSheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: AddTaskBottomSheet(),
        );
      });
}

class ChangeTitle {
  String title;

  ChangeTitle(this.title);
}
