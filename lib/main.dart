import 'package:flutter/material.dart';
import 'package:tafeel_task/core/theme/app_colors.dart';
import 'package:tafeel_task/modules/users/view/users.dart';

void main() {
  runApp(const TafellTask());
}


class TafellTask extends StatelessWidget {
  const TafellTask({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Tafell Task',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.primary,
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            color: AppColors.secondary,
     
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: AppColors.secondary,
            
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: AppColors.secondary,
          ),
        ),
      
      ),
      home: AllUsers()
    );
  }
}