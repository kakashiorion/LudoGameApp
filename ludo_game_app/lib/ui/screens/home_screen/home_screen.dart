import 'package:flutter/material.dart';
import 'package:ludo_game_app/ui/responsive/orientation_layout.dart';
import 'package:ludo_game_app/ui/screens/home_screen/home_screen_mobile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationLayout(
      landscape: HomeScreenMobileLandscape(),
      portrait: HomeScreenMobilePortrait(),
    );
  }
}
