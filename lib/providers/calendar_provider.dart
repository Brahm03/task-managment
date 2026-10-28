import 'package:flutter/material.dart';
import 'package:task_managment/providers/project_provider.dart';

class CalendarProvider extends ChangeNotifier {
  String salomlashish() {
    final hozirgiVaqt = DateTime.now();

    if (hozirgiVaqt.hour >= 5 && hozirgiVaqt.hour <= 11) {
      return "Hayrli tong";
    } else if (hozirgiVaqt.hour > 11 && hozirgiVaqt.hour <= 16) {
      return "Hayrli kun";
    } else {
      return 'Hayrli kech';
    }
  }

  Set<ProjectModel> filtered = {};

  void filterlash(DateTime time, List<ProjectModel> umummiyMalumot) {
    // * Datetime(2026, 09, 12)
    print('Filter sanasi $time');
    filtered.clear();
    for (var i = 0; i < umummiyMalumot.length; i++) {
      if (umummiyMalumot[i].deadLine.isBefore(time) ||
          umummiyMalumot[i].deadLine == time) {
        filtered.add(umummiyMalumot[i]);
      }
    }

    print('Filterlash tugadi ${filtered.length}');
    notifyListeners();
  }
}
