import 'package:flutter/material.dart';

class AddTaskBottomProvider extends ChangeNotifier {
  DateTime selectedDate = DateTime.now();

  void ShowPicker(BuildContext context) async {
    DateTime? chosenDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now().add(
        Duration(days: 365),
      ),
    );
    if (chosenDate == null) return;
    selectedDate = chosenDate;
    notifyListeners();
  }
}
