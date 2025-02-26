import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class FertilizerCalculatorScreen extends StatefulWidget {
  @override
  _FertilizerCalculatorScreenState createState() =>
      _FertilizerCalculatorScreenState();
}

class _FertilizerCalculatorScreenState
    extends State<FertilizerCalculatorScreen> {
  List<Map<String, String>> _cropData = [];
  String? _selectedCrop;
  double _area = 0.0;
  Map<String, double> _fertilizerNeeds = {};

  @override
  void initState() {
    super.initState();
    _loadCropData();
  }

  Future<void> _loadCropData() async {
    final String rawData =
        await rootBundle.loadString('assets/crop_manure_data.csv');
    List<String> lines = rawData.split('\n');
    List<String> headers = lines[0].split(',');

    setState(() {
      _cropData = lines.skip(1).where((line) => line.isNotEmpty).map((line) {
        List<String> values = line.split(',');
        return Map.fromIterables(
            headers.map((e) => e.trim()), values.map((e) => e.trim()));
      }).toList();
    });
  }

  void _calculateFertilizer() {
    if (_selectedCrop != null && _area > 0) {
      final cropInfo = _cropData.firstWhere(
        (crop) => crop['Crop_Name']?.trim() == _selectedCrop?.trim(),
        orElse: () => {},
      );

      if (cropInfo.isNotEmpty) {
        setState(() {
          _fertilizerNeeds = {
            'Nitrogen (N)': double.parse(cropInfo['CurrentNPK_kg'] ?? '0') *
                _area *
                0.03, // 3% Nitrogen
            'Phosphorus (P)': double.parse(cropInfo['CurrentNPK_kg'] ?? '0') *
                _area *
                0.01, // 1% Phosphorus
            'Potassium (K)': double.parse(cropInfo['CurrentNPK_kg'] ?? '0') *
                _area *
                0.01, // 1% Potassium
            'Farmyard Manure (FYM)':
                double.parse(cropInfo['FYM_kg'] ?? '0') * _area,
            'Vermicompost':
                double.parse(cropInfo['Vermicompost_kg'] ?? '0') * _area,
            'Neem Cake': double.parse(cropInfo['Neem_Cake_kg'] ?? '0') * _area,
          };
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fertilizer Calculator 🌿"),
        backgroundColor: const Color(0xFF008080), // Deep Teal
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              hint: const Text('Select a Crop'),
              value: _selectedCrop,
              isExpanded: true,
              items: _cropData
                  .map((crop) => crop['Crop_Name']?.trim())
                  .where((cropName) => cropName != null && cropName.isNotEmpty)
                  .toSet() // Remove duplicates
                  .map((cropName) {
                return DropdownMenuItem(
                  value: cropName,
                  child: Text(cropName ?? ''),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _selectedCrop = value;
                });
              },
            ),
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Area (in hectares)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _area = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateFertilizer,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF9DC183), // Sage Green
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Calculate'),
            ),
            const SizedBox(height: 20),
            if (_fertilizerNeeds.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD700), // Soft Mint
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _fertilizerNeeds.entries
                      .map(
                        (entry) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            '🌱 ${entry.key}: ${entry.value.toStringAsFixed(2)} kg',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
