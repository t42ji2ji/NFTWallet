import 'package:flutter/material.dart';

class CustomTheme {
  static const Color bgColor = Color(0xFF1C1C25);
  static const Color bgSecondColor = Color(0xFF2F2F47);
  static const Color gray = Color.fromARGB(255, 149, 149, 149);
  static const Color primaryColor = Color(0xFFFFD25F);
  static const Color secondColor = Color(0xFF5748FF);

  static const TextStyle textSmallPrimary =
      TextStyle(color: primaryColor, fontSize: 12, fontWeight: FontWeight.w600);
  static const TextStyle textPrimary =
      TextStyle(color: primaryColor, fontSize: 15, fontWeight: FontWeight.w600);
  static const TextStyle textSmallWhite =
      TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600);
  static const TextStyle textWhite =
      TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600);
  static const TextStyle textBoldWhite =
      TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600);
  static const TextStyle textSmallGray =
      TextStyle(color: gray, fontSize: 12, fontWeight: FontWeight.w600);
  static const TextStyle textGray =
      TextStyle(color: gray, fontSize: 15, fontWeight: FontWeight.w600);
  static const TextStyle textBoldGray =
      TextStyle(color: gray, fontSize: 20, fontWeight: FontWeight.w600);
  static const TextStyle textBlack =
      TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600);
  static const TextStyle textBoldBlack =
      TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600);
}
