import 'package:flutter/material.dart';
import 'package:ludo_game_app/ui/responsive/orientation_layout.dart';
import 'package:ludo_game_app/ui/screens/settings_screen/settings_screen_mobile.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OrientationLayout(
      landscape: SettingsScreenMobileLandscape(),
      portrait: SettingsScreenMobilePortrait(),
    );
  }
}
