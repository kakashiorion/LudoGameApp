import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:ludo_game_app/enums/constants.dart';

import 'ui/screens/home_screen/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: appBlue,
        accentColor: appYellow,
      ),
      home: AnimatedSplashScreen(
        splash: 'images/ludo_bg.png',
        duration: 2000,
        nextScreen: new HomeScreen(),
        backgroundColor: appBlue,
        splashTransition: SplashTransition.rotationTransition,
      ),
    );
  }
}

/**TODO:
 * TEST: Singleplayer
 * Settings screen (Player name, Image, Preferred color, etc.)
 * Clicking Play Now goes to a screen showing -> Play with AI, play online multiplayer
 * Play with AI -> Go to game directly
 * Code for AI logic
 * Play online multiplayer -> waiting screen (players joining/leaving, starting game)
 * Firebase setup for multiplayer
 * Add 'game' to Firebase
 * Update 'game' after each 'turn'
 * Download and show the game to each player
 * Multiplayer logic code
 * 
 */
