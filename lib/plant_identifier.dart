import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class PlantIdentifierScreen extends StatefulWidget {
  const PlantIdentifierScreen({Key? key}) : super(key: key);

  @override
  _PlantIdentifierScreenState createState() => _PlantIdentifierScreenState();
}

class _PlantIdentifierScreenState extends State<PlantIdentifierScreen> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  bool isScanning = false;
  String scanResult = "Scan a plant or upload an image to identify 🌿";

  // Capture image from camera
  Future<void> _captureImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        scanResult = "Image captured. Ready to identify!";
      });
    }
  }

  // Upload image from gallery
  Future<void> _uploadFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        scanResult = "Image uploaded. Ready to identify!";
      });
    }
  }

  // Handle scanning from mobile camera
  void _onScanCompleted(String? barcode) {
    setState(() {
      isScanning = false;
      scanResult = "Plant scanned!\nResult: $barcode";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Plant Identifier"),
        backgroundColor: Color(0xFF008080),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isScanning)
                Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF008080), width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: MobileScanner(
                      onDetect: (barcodeCapture) {
                        final List<Barcode> barcodes = barcodeCapture.barcodes;
                        if (barcodes.isNotEmpty) {
                          _onScanCompleted(barcodes.first.rawValue);
                        }
                      },
                    ),
                  ),
                )
              else
                Column(
                  children: [
                    _selectedImage != null
                        ? Image.file(_selectedImage!, height: 200)
                        : Icon(Icons.camera_alt, size: 100, color: Color(0xFF008080)),
                    const SizedBox(height: 20),
                    Text(
                      scanResult,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF008080)),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: _captureImage,
                      icon: const Icon(Icons.photo_camera),
                      label: const Text("Capture Image"),
                      style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF008080)),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: _uploadFromGallery,
                      icon: const Icon(Icons.photo_library),
                      label: const Text("Upload from Gallery"),
                      style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF008080)),
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
