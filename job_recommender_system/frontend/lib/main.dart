import 'package:flutter/material.dart';
import 'package:frontend/ui/home_screen.dart';
import 'package:frontend/ui/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Job Recommender System",
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
