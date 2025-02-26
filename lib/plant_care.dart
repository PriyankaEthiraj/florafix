import 'package:flutter/material.dart';
import 'water_reminder.dart';
import 'water.dart';
import 'fertilizer_calculator.dart';
import 'plant_diary.dart';

class PlantCareScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Plant Care 🌿",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF008080), // Deep Teal
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: const Color(0xFFC7F1DF), // Soft Mint Background
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildCard(
              context,
              title: "Water Reminder",
              icon: Icons.alarm,
              screen: WaterReminderScreen(),
            ),
            _buildCard(
              context,
              title: "Water Calculator",
              icon: Icons.water_drop,
              screen: WaterCalculatorScreen(),
            ),
            _buildCard(
              context,
              title: "Fertilizer Calculator",
              icon: Icons.eco,
              screen: FertilizerCalculatorScreen(),
            ),
            _buildCard(
              context,
              title: "Plant Diary",
              icon: Icons.book,
              screen: PlantDiaryScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Widget screen,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Card(
        color: const Color(0xFF008080), // Deep Teal Cards
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
        shadowColor: Colors.black.withOpacity(0.2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
