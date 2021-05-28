import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Colors
const YellowAppColor = Color(0xfffdc149);
const RedAppColor = Color(0xffD62828);
const BlueAppColor = Color(0xff003049);
const LemonAppColor = Color(0xffEAE2B7);

MaterialColor appYellow =
    MaterialColor(YellowAppColor.value, getSwatch(YellowAppColor));
MaterialColor appBlue =
    MaterialColor(BlueAppColor.value, getSwatch(BlueAppColor));
MaterialColor appRed = MaterialColor(RedAppColor.value, getSwatch(RedAppColor));
MaterialColor appLemon =
    MaterialColor(LemonAppColor.value, getSwatch(LemonAppColor));

Map<int, Color> getSwatch(Color color) {
  final hslColor = HSLColor.fromColor(color);
  final lightness = hslColor.lightness;

  /// if [500] is the default color, there are at LEAST five
  /// steps below [500]. (i.e. 400, 300, 200, 100, 50.) A
  /// divisor of 5 would mean [50] is a lightness of 1.0 or
  /// a color of #ffffff. A value of six would be near white
  /// but not quite.
  final lowDivisor = 6;

  /// if [500] is the default color, there are at LEAST four
  /// steps above [500]. A divisor of 4 would mean [900] is
  /// a lightness of 0.0 or color of #000000
  final highDivisor = 5;

  final lowStep = (1.0 - lightness) / lowDivisor;
  final highStep = lightness / highDivisor;

  return {
    50: (hslColor.withLightness(lightness + (lowStep * 5))).toColor(),
    100: (hslColor.withLightness(lightness + (lowStep * 4))).toColor(),
    200: (hslColor.withLightness(lightness + (lowStep * 3))).toColor(),
    300: (hslColor.withLightness(lightness + (lowStep * 2))).toColor(),
    400: (hslColor.withLightness(lightness + lowStep)).toColor(),
    500: (hslColor.withLightness(lightness)).toColor(),
    600: (hslColor.withLightness(lightness - highStep)).toColor(),
    700: (hslColor.withLightness(lightness - (highStep * 2))).toColor(),
    800: (hslColor.withLightness(lightness - (highStep * 3))).toColor(),
    900: (hslColor.withLightness(lightness - (highStep * 4))).toColor(),
  };
}

//TextStyles
TextStyle mainMenuButtonTextStyle = GoogleFonts.goblinOne(
    textStyle: TextStyle(
  color: RedAppColor,
  fontSize: 16,
  fontWeight: FontWeight.bold,
));

TextStyle playerNameDisplay = GoogleFonts.goblinOne(
    textStyle: TextStyle(
  color: LemonAppColor,
  fontSize: 10,
));

//ButtonStyles
ButtonStyle mainMenuButtonStyle = TextButton.styleFrom(
  shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(width: 4, color: appYellow.shade300)),
  padding: EdgeInsets.all(24),
  backgroundColor: YellowAppColor,
  elevation: 8,
  shadowColor: appYellow[200],
);

//Icons
const safeStepIcon = Icons.stars;
const safeStepIconOccupied = Icons.star;

//Ludo Piece states
enum LudoPieceState { Alive, Dead, Home }
