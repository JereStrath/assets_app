import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_screen.dart'; // Import your login screen
import 'add_assets_page.dart'; // Import your add assets screen
import 'check_assets_page.dart'; // Import your check assets screen
import 'qr_scanner_page.dart'; // Import your QR scanner screen
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'services/firestore_service.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

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
                    "assets/door.png", // Placeholder logo
                    height: 90,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Welcome",
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
                children: [
                  // Buttons
                  buildButton(
                    context, 
                    "Add Assets", 
                    Colors.black, 
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddAssetsPage()),
                    ),
                  ),
                  const SizedBox(height: 15),
                  buildButton(
                    context, 
                    "Check Assets", 
                    Colors.indigo.shade900, 
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CheckAssetsPage()),
                    ),
                  ),
                  const SizedBox(height: 15),
                  buildButton(context, "Share Assets", Colors.black, () {}),
                  const SizedBox(height: 15),
                  buildButton(context, "Backup Your Data", Colors.indigo.shade900, () {}),
                  const SizedBox(height: 15),
                  buildButton(
                    context, 
                    "Logout", 
                    Colors.black, 
                    () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
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
