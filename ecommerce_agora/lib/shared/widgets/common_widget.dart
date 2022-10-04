import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget appButton(Size size, String child, onPress) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      fixedSize: Size(size.width, size.height / 13),
      alignment: Alignment.center,
      primary: const Color(0xFFF56B3F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    onPressed: onPress,
    child: Text(
      child,
      style: GoogleFonts.inter(
        fontSize: 16.0,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
