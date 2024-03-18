import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/tasks.dart';
import 'package:todo/provider/my_provider.dart';
import 'package:todo/shared/network/local/firebase_utils.dart';
import 'package:todo/shared/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../layout/edit_task.dart';

class TaskItem extends StatefulWidget {
  TasksData task;

  TaskItem(this.task);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Slidable(
      startActionPane: ActionPane(
        motion: BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              deleteTasksFromFirestore(widget.task.id);
            },
            backgroundColor: Colors.red,
            label: AppLocalizations.of(context)!.delete,
            icon: Icons.delete,
          ),
          SlidableAction(
            onPressed: (context) {
              BottomSheetEditTask(context, widget.task.id);
              setState(() {});
            },
            backgroundColor: Colors.blue,
            label: AppLocalizations.of(context)!.edit,
            icon: Icons.edit,
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
            color: provider.mode == ThemeMode.light ? Colors.white : colorgrey,
            borderRadius: BorderRadius.circular(12),
            border:
                Border.all(color: widget.task.isDone ? colorGreen : primaryColor)),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Container(
                height: 80,
                width: 4,
                color: widget.task.isDone ? colorGreen : primaryColor),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.task.title,
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: widget.task.isDone ? colorGreen : primaryColor),
                  ),
                  Text(widget.task.description),
                ],
              ),
            ),
            InkWell(
              onTap: () {
               if(!widget.task.isDone){
                 provider.UpdateiSDone(widget.task);
               }
               print(widget.task.isDone);
              },
              child: widget.task.isDone
                  ? Text(
                      "Done!",
                      style: TextStyle(fontSize: 25, color: colorGreen),
                    )
                  : Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.done,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

BottomSheetEditTask(BuildContext context, String id) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return EditTasks(id);
      });
}
