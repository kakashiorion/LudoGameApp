import 'package:flutter/material.dart';
import 'package:ludo_game_app/enums/constants.dart';

class PreGameScreenMobileLandscape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var scaffold = Scaffold(
      backgroundColor: appBlue,
      appBar: PreGameAppBar(context),
    );
    return scaffold;
  }
}

class PreGameScreenMobilePortrait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: appBlue,
      appBar: PreGameAppBar(context),
    );
  }
}

AppBar PreGameAppBar(context) {
  return AppBar(
    title: Text(
      'PreGame',
      style: mainMenuButtonTextStyle,
    ),
    backgroundColor: appYellow,
    elevation: 10,
    leading: IconButton(
      icon: Icon(Icons.arrow_back),
      color: appBlue,
      onPressed: () {
        Navigator.pop(context);
      },
    ),
  );
}
