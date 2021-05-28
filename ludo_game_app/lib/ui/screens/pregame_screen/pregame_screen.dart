import 'package:flutter/material.dart';
import 'package:ludo_game_app/ui/responsive/orientation_layout.dart';

import 'pregame_screen_mobile.dart';

class PreGameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OrientationLayout(
      landscape: PreGameScreenMobileLandscape(),
      portrait: PreGameScreenMobilePortrait(),
    );
  }
}
