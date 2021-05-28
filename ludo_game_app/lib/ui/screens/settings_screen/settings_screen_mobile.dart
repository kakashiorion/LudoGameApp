import 'package:flutter/material.dart';
import 'package:ludo_game_app/enums/constants.dart';

class SettingsScreenMobileLandscape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var scaffold = Scaffold(
      backgroundColor: appBlue,
      appBar: SettingsAppBar(context),
    );
    return scaffold;
  }
}

class SettingsScreenMobilePortrait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: appBlue,
      appBar: SettingsAppBar(context),
    );
  }
}

AppBar SettingsAppBar(context) {
  return AppBar(
    title: Text(
      'Settings',
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
