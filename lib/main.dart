import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'plant_identifier.dart';
import 'plant_diagnosis.dart';
import 'plant_care.dart';
import 'settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;
  bool _notificationsEnabled = true;
  bool _isLoggedIn = false;

  void _toggleDarkMode(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  void _toggleNotifications(bool value) {
    setState(() {
      _notificationsEnabled = value;
    });
  }

  void _onLoginSuccess() {
    setState(() {
      _isLoggedIn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FloraFix 🌿',
      theme: ThemeData(
        primaryColor: const Color(0xFF008080), // Deep Teal
        scaffoldBackgroundColor: const Color(0xFFC7F1DF), // Light Green
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF008080), // Deep Teal
          selectedItemColor: Color(0xFF9DC183), // Sage Green
          unselectedItemColor: Color(0xFF9DC183), // Sage Green
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xFF008080)), // Deep Teal
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFF008080), // Deep Teal Input Field Background
          border: OutlineInputBorder(),
          labelStyle: TextStyle(color: Colors.white), // Input Field Text
          prefixIconColor: Colors.white, // Input Icons
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFF9DC183), // Sage Green
        ),
      ),
      home: _isLoggedIn
          ? HomeScreen(
              isDarkMode: _isDarkMode,
              onThemeChange: _toggleDarkMode,
              onNotificationToggle: _toggleNotifications,
            )
          : LoginScreen(onLoginSuccess: _onLoginSuccess),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChange;
  final Function(bool) onNotificationToggle;

  const HomeScreen({
    Key? key,
    required this.isDarkMode,
    required this.onThemeChange,
    required this.onNotificationToggle,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      PlantIdentifierScreen(),
      PlantDiagnosisScreen(),
      PlantCareScreen(),
      SettingsScreen(
        isDarkMode: widget.isDarkMode,
        notificationsEnabled: true,
        onThemeChange: widget.onThemeChange,
        onNotificationToggle: widget.onNotificationToggle,
      ),
    ];

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF008080), // Deep Teal
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF9DC183), // Sage Green (Active Icon)
        unselectedItemColor: const Color(0xFF9DC183), // Sage Green (Inactive Icon)
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.nature), label: 'Identify'),
          BottomNavigationBarItem(icon: Icon(Icons.local_hospital), label: 'Diagnosis'),
          BottomNavigationBarItem(icon: Icon(Icons.spa), label: 'Plant Care'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
