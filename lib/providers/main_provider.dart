import 'package:flutter/material.dart';
import 'package:task_managment/screens/calendar_screen.dart';
import 'package:task_managment/screens/project_list_screen.dart';

class MainProvider extends ChangeNotifier {
  int hozirPage = 0;

  List<Widget> pagelar = [
    SizedBox(),
    ProjectListScreen(),
    CalendarScreen(),
    SizedBox(),
    SizedBox(),
  ];

  void changePage(int page) {
    hozirPage = page;
    notifyListeners();
  }
}
