import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Florogenix"),
        backgroundColor: Colors.teal[700], // Updated theme color
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // App Logo with Shadow
            Container(
              decoration: BoxDecoration(
                color: Colors.teal[50],
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.teal.withOpacity(0.3),
                    spreadRadius: 4,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Icon(Icons.eco, size: 60, color: Colors.teal[700]),
              ),
            ),
            const SizedBox(height: 15),

            // App Name
            Text(
              "🌿 Florogenix",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.teal[800],
              ),
            ),
            const SizedBox(height: 5),

            // Version & Developer Info
            Text("Version: 1.0.0", style: TextStyle(fontSize: 16, color: Colors.teal[600])),
            Text("Developed by: Pretty Shetty", style: TextStyle(fontSize: 16, color: Colors.teal[600])),
            const SizedBox(height: 20),

            // Purpose Section
            _buildCard(
              title: "📌 Purpose of Florogenix",
              content:
                  "Florogenix is an AI-powered smart gardening assistant that helps users identify plant diseases, schedule watering reminders, and track plant growth effortlessly.",
            ),
            const SizedBox(height: 20),

            // Features Section
            _buildFeatureCard(),
            const SizedBox(height: 20),

            // Back Button
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text("Back to Settings"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[700],
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Generic Card Widget
  Widget _buildCard({required String title, required String content}) {
    return Card(
      elevation: 4,
      shadowColor: Colors.teal.withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal[700],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              content,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  // Features Card
  Widget _buildFeatureCard() {
    return Card(
      elevation: 4,
      shadowColor: Colors.teal.withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "🌱 Features",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal[700],
              ),
            ),
            const SizedBox(height: 10),
            _buildFeatureRow(Icons.science, "Plant Disease Detection"),
            _buildFeatureRow(Icons.water_drop, "Smart Water Reminders"),
            _buildFeatureRow(Icons.book, "Plant Diary & Care Guide"),
            _buildFeatureRow(Icons.eco, "Fertilizer & Soil Monitoring"),
          ],
        ),
      ),
    );
  }

  // Feature Row Widget
  Widget _buildFeatureRow(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.teal[700]),
          const SizedBox(width: 10),
          Text(title, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
