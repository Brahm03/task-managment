import 'package:flutter/material.dart';
import 'package:task_managment/consts/app_colors.dart';

class AppThemes {
  static final light = ThemeData(
      cardTheme: CardThemeData(
        elevation: 0,
        color: AppColors.lightGrey
      ),
      scaffoldBackgroundColor: AppColors.white,
      colorScheme: ColorScheme.light(primary: AppColors.primary));
  static final dark = ThemeData(
      cardTheme: CardThemeData(
        color: AppColors.dark,
        elevation: 0
      ),
      bottomAppBarTheme: BottomAppBarThemeData(color: AppColors.grey),
      colorScheme: ColorScheme.dark(primary: AppColors.primary));
}
