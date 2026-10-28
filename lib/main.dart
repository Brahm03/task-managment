import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_managment/consts/app_themes.dart';
import 'package:task_managment/providers/project_provider.dart';
import 'package:task_managment/screens/main_screen.dart';
import 'package:task_managment/screens/project_list_screen.dart';

const bool isAdmin = false;

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ProjectProvider())
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.light,
      darkTheme: AppThemes.dark,
      themeMode: ThemeMode.system,
      home: MainScreen(),
    );
  }
}
