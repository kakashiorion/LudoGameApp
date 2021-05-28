import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ludo_game_app/enums/constants.dart';

class MainMenuButtonMobile extends StatelessWidget {
  final Function() onTap;
  final String title;

  const MainMenuButtonMobile(
      {Key? key, required this.onTap, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return SizedBox(
      height: mediaQuery.orientation == Orientation.landscape
          ? max(mediaQuery.size.shortestSide / 8, 64)
          : max(mediaQuery.size.longestSide / 16, 64),
      width: max(mediaQuery.size.shortestSide / 2, 160),
      child: TextButton(
        onPressed: onTap,
        style: mainMenuButtonStyle,
        child: Text(
          title,
          style: mainMenuButtonTextStyle,
        ),
      ),
    );
  }
}
