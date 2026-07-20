import 'package:flutter/material.dart';
import '../main.dart'; // For AppColors

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Typical for a camera/scanner screen
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Scan Receipt', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_off_rounded),
            onPressed: () {},
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Simulated camera view
          Container(
            color: Colors.black87,
            width: double.infinity,
            height: double.infinity,
          ),
          
          // Scanner overlay frame
          Container(
            width: 300,
            height: 400,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary, width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          
          // Scan instructions
          const Positioned(
            bottom: 120,
            child: Text(
              'Align receipt within the frame',
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),

          // Capture button
          Positioned(
            bottom: 40,
            child: Material(
              color: AppColors.primary,
              shape: const CircleBorder(
                side: BorderSide(color: Colors.white, width: 4),
              ),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () {
                  // Return back after scan
                  Navigator.of(context).pop();
                },
                child: SizedBox(
                  width: 72,
                  height: 72,
                  child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 32),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
