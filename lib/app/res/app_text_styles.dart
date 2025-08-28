import 'package:flutter/material.dart';
import 'package:khata_app/app/res/app_colors.dart';
import 'package:khata_app/app/res/app_fonts.dart';

abstract class AppTextStyles {
  AppTextStyles._();

  /// A flexible custom text style
  static TextStyle customText({
    Color color = Colors.white,
    FontWeight fontWeight = FontWeight.normal,
    double fontSize = 12,
    double letterSpacing = 0,
    double? height,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height,
      fontFamily: AppFonts.poetsenOneRegular,
    );
  }

  /// Predefined styles
  static TextStyle get bold16 => customText(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get medium14 => customText(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get regular12 => customText(
        fontSize: 12,
      );

  static TextStyle get small10 => customText(
        fontSize: 10,
      );

  static TextStyle get white18Bold => customText(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get black18Bold => customText(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      );
}
