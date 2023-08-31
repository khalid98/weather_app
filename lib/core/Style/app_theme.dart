import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/core/Style/app_colors.dart';

class AppStyle {
  static get apptheme =>ThemeData(
    backgroundColor: AppColors.lightBackgroundColor,
    primaryColor:AppColors.textColor,
    textTheme: TextTheme(
      headline1: GoogleFonts.montserrat(
        fontSize: 15,
        fontWeight: FontWeight.w300,
        color: AppColors.textColor
      ),
      headline2: GoogleFonts.montserrat(
        fontSize: 13,
        fontWeight: FontWeight.w300,
        color: AppColors.subTextColor
      ),
      headline3: GoogleFonts.montserrat(
        fontSize: 49,
        fontWeight: FontWeight.w400,
      ),
      headline4: GoogleFonts.montserrat(
        fontSize: 35,
        fontWeight: FontWeight.w400,
      ),
      headline5: GoogleFonts.montserrat(
        fontSize: 24,
        fontWeight: FontWeight.w400,
      ),
      headline6: GoogleFonts.montserrat(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      subtitle1: GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      subtitle2: GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      bodyText1: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      bodyText2: GoogleFonts.openSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      button: GoogleFonts.openSans(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
    useMaterial3: true,
  );}
