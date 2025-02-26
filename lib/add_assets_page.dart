import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'import_assets_page.dart'; // Import the Import Assets page
import 'collect_assets_page.dart'; // Import the Collect Assets page
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddAssetsPage extends StatelessWidget {
  const AddAssetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Background color
      body: Column(
        children: [
          // Upper section with background and icon
          Container(
            height: MediaQuery.of(context).size.height * 0.35, // 35% of screen height
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.png"), // Background pattern
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/add.png", // Placeholder icon
                    height: 90,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Add Assets",
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom section with buttons
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "DO YOU WANT TO:",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Buttons
                  buildButton(
                    context, 
                    "Import Assets", 
                    Colors.black, 
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ImportAssetsPage()),
                    ),
                  ),
                  const SizedBox(height: 15),
                  buildButton(
                    context, 
                    "Collect Assets", 
                    Colors.indigo.shade900, 
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CollectAssetsPage()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Reusable button widget
  Widget buildButton(BuildContext context, String text, Color color, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
