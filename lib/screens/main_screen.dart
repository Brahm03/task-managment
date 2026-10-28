import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_managment/providers/main_provider.dart';
import 'package:task_managment/widgets/app_bottom_nav.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainProvider(),
      child: Builder(builder: (context) {
        return Scaffold(
          body: context.watch<MainProvider>().pagelar[context.watch<MainProvider>().hozirPage],
          bottomNavigationBar: AppBottomNav(
              onTap: (value) {
                context.read<MainProvider>().changePage(value);
              },
              currentIndex: context.watch<MainProvider>().hozirPage),
        );
      }),
    );
  }
}
