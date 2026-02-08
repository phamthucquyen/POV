import 'package:flutter/material.dart';
import '../camera/scan_screen.dart';
import '../location/location_screen.dart';
import '../profile/profile_dashboard.dart';
import '../wrap/wrap_screen.dart';

import '../chatbot/chatbot_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 2; 

  final List<Widget> _pages = const [
    WrapScreen(),
    LocationScreen(),
    ScanScreen(),
    ChatbotScreen(),
    ProfileDashboard()
  ];

  static const double _iconSize = 28; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],

      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide, 
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.calendar_month, size: _iconSize),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.location_on, size: _iconSize),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.camera_alt, size: _iconSize),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.search, size: _iconSize),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.person, size: _iconSize),
            label: '',
          ),
        ],
      ),
    );
  }
}
