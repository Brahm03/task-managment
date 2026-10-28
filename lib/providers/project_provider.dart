import 'package:flutter/material.dart';
import 'package:task_managment/consts/app_assets.dart';
import 'package:task_managment/consts/app_colors.dart';

class ProjectProvider extends ChangeNotifier {
  static final Person _p1 = Person(
      image: AppImages.avatar1, name: "Abubakir", phoneNumber: "+998998894484");
  static final Person _p2 = Person(
      image: AppImages.avatar2, name: "Murod", phoneNumber: "+998998894484");
  static final Person _p3 = Person(
      image: AppImages.avatar3, name: "Aziz", phoneNumber: "+998998894484");
  static final Person _p4 = Person(
      image: AppImages.avatar4, name: "Jasur", phoneNumber: "+998998894484");
  static final Person _p5 = Person(
      image: AppImages.avatar5, name: "Malika", phoneNumber: "+998998894484");

  static List<TaskModel> _tasks() => [
        TaskModel(
            title: 'Create Design System',
            hours: 25,
            members: [_p3, _p4],
            isDone: true),
        TaskModel(
            title: 'Create Wireframe',
            hours: 18,
            members: [_p1, _p2],
            isDone: true),
        TaskModel(title: 'Landing Page Design', hours: 8, members: [_p5]),
        TaskModel(
            title: 'Mobile Screen Design', hours: 40, members: [_p2, _p3, _p4]),
      ];

  List<String> userImages = [
    "https://plus.unsplash.com/premium_photo-1689539137236-b68e436248de?q=80&w=2942&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=NHwxMjA3fDA%3D",
    "https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=1528&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=NHwxMjA3fDA%3D",
    "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=1287&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=NHwxMjA3fDA%3D",
    "https://images.unsplash.com/photo-1552058544-f2b08422138a?q=80&w=1299&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=NHwxMjA3fDA%3D",
    "https://plus.unsplash.com/premium_photo-1689551670902-19b441a6afde?q=80&w=1287&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=NHwxMjA3fDA%3D"
  ];

  int tanlanganRasm = -1;

  void rasmTanlash(int index) {
    tanlanganRasm = index;
    notifyListeners();
  }

  void addMember(String userName, String image) {
    team.add(
        Person(image: image, name: userName, phoneNumber: "+998901234567"));
    notifyListeners();
  }

  List<Person> team = [
    Person(
        phoneNumber: '+998908998239239',
        image:
            "https://images.unsplash.com/photo-1599566150163-29194dcaad36?q=80&w=1287&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=NHwxMjA3fDA%3D",
        name: 'Jackson'),
    Person(
        phoneNumber: '+998908998239239',
        image:
            "https://plus.unsplash.com/premium_photo-1689539137236-b68e436248de?q=80&w=2942&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=NHwxMjA3fDA%3D",
        name: 'Thakur')
  ];

  List<ProjectModel> projects = [
    ProjectModel(
        cmds: ['UI qismi tugadi', "Qachon tugating ?"],
        deadLine: DateTime(2026, 7, 20),
        description:
            'Fintech app development provides more freedom to banking and other financial institutions.',
        group: [_p1, _p2, _p3, _p4, _p5],
        name: 'Fintech Mobile App UI',
        image: AppImages.fintech,
        color: AppColors.yellowCard,
        hours: 91,
        progress: 0.52,
        tasks: _tasks()),
    ProjectModel(
        cmds: [],
        deadLine: DateTime(2026, 6, 12),
        description:
            'GreenSky DG focuses on evaluating and developing solar opportunities for landholders',
        group: [_p1, _p2, _p3, _p4, _p5],
        name: 'Green sky Website Dev',
        image: AppImages.greenSky,
        imageFit: BoxFit.contain,
        color: AppColors.mintCard,
        hours: 91,
        progress: 0.52,
        tasks: _tasks()),
    ProjectModel(
        cmds: [],
        deadLine: DateTime(2026, 7, 20),
        description:
            'Fintech app development provides more freedom to banking and other financial institutions.',
        group: [_p1, _p2, _p3, _p4, _p5],
        name: 'Unsaid Events',
        image: AppImages.unsaid,
        color: AppColors.mintCard,
        hours: 91,
        progress: 0.52,
        tasks: _tasks()),
    ProjectModel(
        cmds: [],
        deadLine: DateTime(2026, 6, 12),
        description:
            'GreenSky DG focuses on evaluating and developing solar opportunities for landholders',
        group: [_p1, _p2, _p3, _p4, _p5],
        name: 'Chrome Heart',
        image: AppImages.chrome,
        color: AppColors.purpleCard,
        hours: 91,
        progress: 0.52,
        tasks: _tasks()),
  ];

  void toggleTask(TaskModel task) {
    task.isDone = !task.isDone;
    notifyListeners();
  }

  void delete(int index) {
    projects.removeAt(index);
    notifyListeners();
  }
}

class ProjectModel {
  String name;
  String description;
  DateTime deadLine;
  List<Person> group;
  List<String> cmds;
  String image;
  BoxFit imageFit;
  Color color;
  int hours;
  double progress;
  List<TaskModel> tasks;

  ProjectModel(
      {required this.cmds,
      required this.deadLine,
      required this.description,
      required this.group,
      required this.name,
      required this.image,
      required this.color,
      required this.hours,
      required this.progress,
      required this.tasks,
      this.imageFit = BoxFit.cover});
}

class TaskModel {
  String title;
  int hours;
  List<Person> members;
  bool isDone;

  TaskModel(
      {required this.title,
      required this.hours,
      required this.members,
      this.isDone = false});
}

class Person {
  String name;
  String image;
  String phoneNumber;
  Person({required this.image, required this.name, required this.phoneNumber});
}
