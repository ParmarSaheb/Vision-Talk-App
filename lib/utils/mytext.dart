import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget myText(
  String title,
  {
  Color? bgColor,
  Color? textColor,
  double? fontsize,
  FontWeight? fontweight,
  TextStyle? style,
}) =>
    Text(
      title,
      style: GoogleFonts.poppins(
        backgroundColor: bgColor,
        color: textColor ?? Colors.black,
        fontSize: fontsize,
        fontWeight: fontweight, 
        textStyle: style,        
      ),
    );
