import 'package:flutter/material.dart';

// Define color constants based on the image provided
const Color kBlack = Color(0xFF0B0B0B); // Black color
const Color kBlueAccent =
    Color(0xFF2A86FF); // Blue Accent (replacing the green)
const Color kDarkGray = Color(0xFF2D2D2D); // Dark Gray
const Color kPurpleAccent = Color(0xFF925FF0); // Purple Accent
const Color kSmokeWhite = Color(0xFFF5F5F5); // Smoke White

// Additional colors for text, buttons, and backgrounds
const Color kTextColorPrimary = Color(0xFFFFFFFF); // White for primary text
const Color kTextColorSecondary =
    Color(0xFF8E8E8E); // Light Gray for secondary text
const Color kButtonColor = kBlueAccent; // Button color
const Color kBackgroundColor = kBlack; // Background color

// Function to lighten a color
Color lighten(Color color, [double amount = 0.1]) {
  final hsl = HSLColor.fromColor(color);
  final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
  return hslLight.toColor();
}

// Function to darken a color
Color darken(Color color, [double amount = 0.1]) {
  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
  return hslDark.toColor();
}

//bg
Color backgroundColor1 = const Color(0xffE9EAF7);
Color backgroundColor2 = const Color(0xffF4EEF2);
Color backgroundColor3 = const Color(0xffEBEBF2);
Color backgroundColor4 = const Color(0xffE3EDF5);
Color primaryColor = const Color(0xffD897FD);
Color textColor1 = const Color(0xff353047);
Color textColor2 = const Color(0xff6F6B7A);
Color buttonColor = const Color(0xffFD6B68);
