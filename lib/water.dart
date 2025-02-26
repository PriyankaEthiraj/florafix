import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class WaterCalculatorScreen extends StatefulWidget {
  @override
  _WaterCalculatorScreenState createState() => _WaterCalculatorScreenState();
}

class _WaterCalculatorScreenState extends State<WaterCalculatorScreen> {
  bool isScanning = false;
  String scanResult = "Scan a plant to get water details";

  void _onScanCompleted(String? barcode) {
    setState(() {
      isScanning = false;
      scanResult =
          "🌿 Plant recognized!\n💧 Current Water Level: 60%\n💦 Required Water: 40%";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Water Calculator"),
        backgroundColor: const Color(0xFF008080), // Deep Teal
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isScanning)
                Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFFFD700), width: 3), // Soft Mint
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: MobileScanner(
                    onDetect: (barcodeCapture) {
                      final List<Barcode> barcodes = barcodeCapture.barcodes;
                      if (barcodes.isNotEmpty) {
                        _onScanCompleted(barcodes.first.rawValue);
                      }
                    },
                  ),
                )
              else
                Column(
                  children: [
                    Text(
                      scanResult,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF008080), // Deep Teal
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          isScanning = true;
                        });
                      },
                      icon: const Icon(Icons.qr_code_scanner),
                      label: const Text("Start Scanning"),
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
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
