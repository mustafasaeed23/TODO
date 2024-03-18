import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/shared/network/local/firebase_utils.dart';

import '../models/tasks.dart';

class MyProvider extends ChangeNotifier {
  ThemeMode mode = ThemeMode.light;
  String languageCode = 'en';
  bool isDone = false;
  void ChangeLanguage(String lang) {
    languageCode = lang;
    notifyListeners();
  }

  void ChangeTheme(ThemeMode theme) {
    mode = theme;
    notifyListeners();
  }

  void UpdateiSDone(TasksData done) {
    isDone = true;
    notifyListeners();
  }
}
