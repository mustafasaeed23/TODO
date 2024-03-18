import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/tasks.dart';
import 'package:todo/provider/add_task_bottom.dart';
import 'package:todo/provider/my_provider.dart';
import 'package:todo/shared/components/components.dart';
import '../shared/network/local/firebase_utils.dart';
import '../shared/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var titleController = TextEditingController();

  var descriptionController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AddTaskBottomProvider(),
        builder: (context, index) {
          var provider = Provider.of<AddTaskBottomProvider>(context);
          var pro = Provider.of<MyProvider>(context);
          return SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    AppLocalizations.of(context)!.addNewTask,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: pro.mode == ThemeMode.light?colorBlack : Colors.white, fontSize: 30),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (text) {
                            if (text == "") {
                              return AppLocalizations.of(context)!.please_enter_task_title;
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
                              child: Text(AppLocalizations.of(context)!.title),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          maxLines: 4,
                          validator: (text) {
                            if (text == "") {
                              return AppLocalizations.of(context)!.please_enter_task_description;
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
                              child: Text(AppLocalizations.of(context)!.description),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.select,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: pro.mode == ThemeMode.light?colorBlack : Colors.white,

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
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: pro.mode == ThemeMode.light?colorBlack : Colors.white,
                      ),

                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        TasksData task = TasksData(
                            title: titleController.text,
                            description: descriptionController.text,
                            date: DateUtils.dateOnly(provider.selectedDate)
                                .microsecondsSinceEpoch);
                        showLoading(context, "Loading.....");
                        showMessage(context, AppLocalizations.of(context)!.sure_Add_task,
                            AppLocalizations.of(context)!.yes, () {
                          addTasksToFirebaseFirestore(task);
                          hideLoading(context);
                          Navigator.pop(context);
                          Navigator.pop(context);

                        },negBtn: AppLocalizations.of(context)!.cancel,negAction: (){
                          hideLoading(context);
                          Navigator.pop(context);
                          Navigator.pop(context);

                        });
                      }
                    },
                    child: Text(AppLocalizations.of(context)!.add_task),
                  )
                ],
              ),
            ),
          );
        });
  }
}
