import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/add_task_bottom.dart';
import 'package:todo/provider/my_provider.dart';
import 'package:todo/shared/network/local/firebase_utils.dart';
import '../models/tasks.dart';
import '../shared/components/components.dart';
import '../shared/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditTasks extends StatefulWidget {
  static const String routeName = "edit";
  String id;

  EditTasks(this.id);

  @override
  State<EditTasks> createState() => _EditTasksState();
}

class _EditTasksState extends State<EditTasks> {
  var titleController = TextEditingController();

  var descriptionController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddTaskBottomProvider(),
      builder: (context, child) {
        var provider = Provider.of<AddTaskBottomProvider>(context);
        var pro = Provider.of<MyProvider>(context);
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: MediaQuery.of(context).size.height * 0.1,
            title: Text("To Do List"),
          ),
          body: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: pro.mode == ThemeMode.light ? Colors.white : colorgrey,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.edit_task,
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          color: pro.mode == ThemeMode.light
                              ? colorBlack
                              : Colors.white,
                        ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (text) {
                            if (text == "") {
                              return AppLocalizations.of(context)!
                                  .please_enter_task_title;
                            } else {
                              return null;
                            }
                          },
                          controller: titleController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: primaryColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: primaryColor,
                              ),
                            ),
                            label: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                AppLocalizations.of(context)!.title,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          validator: (text) {
                            if (text == "") {
                              return AppLocalizations.of(context)!
                                  .please_enter_task_description;
                            } else {
                              return null;
                            }
                          },
                          controller: descriptionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: primaryColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: primaryColor,
                              ),
                            ),
                            label: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                AppLocalizations.of(context)!.description,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          AppLocalizations.of(context)!.select,
                          style:
                              Theme.of(context).textTheme.subtitle1?.copyWith(
                                    color: pro.mode == ThemeMode.light
                                        ? colorBlack
                                        : Colors.white,
                                  ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            provider.ShowPicker(context);
                          },
                          child: Text(
                            "${provider.selectedDate.year}/ ${provider.selectedDate.month} / ${provider.selectedDate.day}",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .3,
                        ),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            )),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                TasksData tas1 = TasksData(
                                    title: titleController.text,
                                    description: descriptionController.text,
                                    id: widget.id,
                                    date: DateUtils.dateOnly(
                                            provider.selectedDate)
                                        .microsecondsSinceEpoch);
                                showLoading(context, "Loading....");
                                EditTasksFromFirestore(tas1);
                                hideLoading(context);
                                Navigator.pop(context);

                              }
                            },
                            child:
                                Text(AppLocalizations.of(context)!.savechange),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
