import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/tasks.dart';
import 'package:todo/modules/tasks_list/task_item.dart';
import 'package:todo/shared/network/local/firebase_utils.dart';
import 'package:todo/shared/styles/colors.dart';

class TasksListTab extends StatefulWidget {
  @override
  State<TasksListTab> createState() => _TasksListTabState();
}

class _TasksListTabState extends State<TasksListTab> {
  DateTime CurrentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CalendarTimeline(
            initialDate: CurrentDate,
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (date) {
              CurrentDate = date;
              setState(() {});
            },
            leftMargin: 20,
            monthColor: colorBlack,
            dayColor: primaryColor,
            activeDayColor: Colors.white,
            activeBackgroundDayColor: primaryColor,
            dotsColor: Colors.white,
            selectableDayPredicate: (date) => true,
            locale: 'en_ISO',
          ),
          StreamBuilder<QuerySnapshot<TasksData>>(
            stream: getTasksFromFirestroe(CurrentDate),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Text("Somthing went wrong");
              }

              var tasks =
                  snapshot.data?.docs.map((doc) => doc.data()).toList() ?? [];
              if (tasks.isEmpty) {
                return Center(child: Text("No Data"));
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return TaskItem(tasks[index]);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
