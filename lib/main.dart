import 'package:flutter/material.dart';
import 'package:kids_learning/screens/home_screen.dart';
import 'package:kids_learning/screens/splash_screen.dart';

void main() {
  runApp(const KidsLearningApp());
}

class KidsLearningApp extends StatelessWidget {
  const KidsLearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kids Learning App',
       theme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.dark, 
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green, 
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.green, 
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, 
            backgroundColor: Colors.green, 
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), 
            ),
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
