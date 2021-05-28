import 'package:flutter/material.dart';
import 'package:ludo_game_app/ui/responsive/orientation_layout.dart';
import 'package:ludo_game_app/utils/game.dart';
import 'package:ludo_game_app/utils/player.dart';
import 'package:provider/provider.dart';

import 'game_screen_mobile.dart';

// ignore: must_be_immutable
class GameScreen extends StatelessWidget {
  GameScreen({Key? key, required this.numberOfPlayers}) : super(key: key);

  final int numberOfPlayers;
  LudoPlayer _player1 = new LudoPlayer(
    playing: false,
    playerImage: Image.asset('images/ludo_bg.png'),
    playerName: 'Player 1',
    playerColor: Colors.blue,
    homePosition: 58,
    startPosition: 2,
  );
  LudoPlayer _player2 = new LudoPlayer(
    playing: false,
    playerImage: Image.asset('images/ludo_bg.png'),
    playerName: 'Player 2',
    playerColor: Colors.green,
    homePosition: 64,
    startPosition: 15,
  );
  LudoPlayer _player3 = new LudoPlayer(
    playing: false,
    playerImage: Image.asset('images/ludo_bg.png'),
    playerName: 'Player 3',
    playerColor: Colors.yellow,
    homePosition: 70,
    startPosition: 28,
  );
  LudoPlayer _player4 = new LudoPlayer(
    playing: false,
    playerImage: Image.asset('images/ludo_bg.png'),
    playerName: 'Player 4',
    playerColor: Colors.red,
    homePosition: 76,
    startPosition: 41,
  );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LudoGame>(
        create: (_) => LudoGame.startGame(
            numberOfPlayers, _player1, _player2, _player3, _player4),
        builder: (context, _) {
          return OrientationLayout(
            landscape: GameScreenMobileLandscape(),
            portrait: GameScreenMobilePortrait(),
          );
        });
  }
}
