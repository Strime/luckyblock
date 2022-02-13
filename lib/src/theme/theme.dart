import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const backgroundColor = Color.fromARGB(255, 24, 24, 24);

var titleColor = Colors.yellow[400];
const textColor = Color.fromARGB(255, 224, 224, 224);

mixin MyTheme {
  static final ThemeData defaultTheme = _buildTheme();

  static ThemeData _buildTheme() {
    final ThemeData base = ThemeData(
      primarySwatch: Colors.yellow,
      brightness: Brightness.dark,
    );
    return base.copyWith(
      textTheme: GoogleFonts.robotoTextTheme(base.textTheme).copyWith(
        headline4: GoogleFonts.ubuntu(
            fontWeight: FontWeight.bold, color: titleColor, fontSize: 25),
        headline5: GoogleFonts.ubuntu(
            fontWeight: FontWeight.bold, color: titleColor, fontSize: 21),
        headline6: GoogleFonts.ubuntu(
            fontWeight: FontWeight.w500, color: titleColor, fontSize: 15),
        bodyText1: GoogleFonts.ubuntu(
            fontWeight: FontWeight.w400, color: titleColor, fontSize: 14),
        button: GoogleFonts.roboto(
            fontWeight: FontWeight.w500, color: titleColor, fontSize: 15),
      ),
      scaffoldBackgroundColor: backgroundColor,
      backgroundColor: backgroundColor,
      appBarTheme: base.appBarTheme.copyWith(
        elevation: 0,
        color: backgroundColor,
        iconTheme: IconThemeData(color: titleColor),
        foregroundColor: titleColor,
      ),
    );
  }
}
