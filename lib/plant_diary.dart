import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PlantDiaryScreen extends StatefulWidget {
  @override
  _PlantDiaryScreenState createState() => _PlantDiaryScreenState();
}

class _PlantDiaryScreenState extends State<PlantDiaryScreen> {
  final List<PlantEntry> _entries = [];

  File? _image;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _healthController = TextEditingController();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _addEntry() {
    if (_image != null &&
        _nameController.text.isNotEmpty &&
        _healthController.text.isNotEmpty) {
      setState(() {
        _entries.add(
          PlantEntry(
            image: _image!,
            name: _nameController.text,
            healthStatus: _healthController.text,
            notes: _notesController.text,
            dateTime: DateTime.now(),
          ),
        );

        // Clear fields after adding entry
        _image = null;
        _nameController.clear();
        _healthController.clear();
        _notesController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🌿 Plant Diary"),
        backgroundColor: const Color(0xFF008080), // Deep Teal
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      spreadRadius: 2,
                      offset: const Offset(2, 2),
                    )
                  ],
                ),
                child: _image == null
                    ? const Center(
                        child: Text(
                          '📷 Tap to upload a plant image',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(_image!, fit: BoxFit.cover),
                      ),
              ),
            ),
            const SizedBox(height: 16),
            _buildTextField(_nameController, "Plant Name", Icons.local_florist),
            const SizedBox(height: 12),
            _buildTextField(_healthController, "Health Status", Icons.health_and_safety),
            const SizedBox(height: 12),
            _buildTextField(_notesController, "Notes (optional)", Icons.note, maxLines: 3),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _addEntry,
                icon: const Icon(Icons.add),
                label: const Text("Add to Diary"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF008080), // Deep Teal
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              '🌱 Your Plant Entries',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _entries.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        'No entries yet! Add your first plant. 🌿',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _entries.length,
                    itemBuilder: (context, index) {
                      final entry = _entries[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                        shadowColor: Colors.black26,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              entry.image,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            entry.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              '🩺 Health: ${entry.healthStatus}\n📝 Notes: ${entry.notes}\n📅 Date: ${entry.dateTime.toLocal().toString().split('.')[0]}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF008080)), // Icon color matches theme
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      maxLines: maxLines,
    );
  }
}

class PlantEntry {
  final File image;
  final String name;
  final String healthStatus;
  final String notes;
  final DateTime dateTime;

  PlantEntry({
    required this.image,
    required this.name,
    required this.healthStatus,
    required this.notes,
    required this.dateTime,
  });
}
