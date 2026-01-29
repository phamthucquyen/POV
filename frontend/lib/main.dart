import 'package:flutter/material.dart';
import 'screens/onboarding/onboarding_screen.dart';

void main() {
  runApp(const LandmarkApp());
}

class LandmarkApp extends StatelessWidget {
  const LandmarkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Landmark Identify',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFEDFFFC),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8EE6DA),
          background: const Color(0xFFEDFFFC),
        ),
      ),
      home: const OnboardingScreen(),
    );
  }
}
