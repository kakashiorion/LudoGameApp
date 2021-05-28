import 'package:flutter/material.dart';
import 'package:ludo_game_app/enums/constants.dart';
import 'package:ludo_game_app/ui/screens/home_screen/home_screen.dart';
import 'package:ludo_game_app/ui/widgets/buttons/base_button.dart';
import 'package:ludo_game_app/ui/widgets/buttons/dice_button.dart';
import 'package:ludo_game_app/ui/widgets/buttons/step_button.dart';
import 'package:ludo_game_app/utils/game.dart';
import 'package:ludo_game_app/utils/player.dart';
import 'package:provider/provider.dart';

class GameScreenMobileLandscape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Consumer<LudoGame>(builder: (context, game, child) {
      return WillPopScope(
        onWillPop: () async {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: appLemon,
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Are you sure you want to leave the game? ',
                        style: mainMenuButtonTextStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: appBlue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4))),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Yes',
                            style: playerNameDisplay.copyWith(
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        },
                      )
                    ],
                  ),
                );
              });
          return false;
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: appBlue,
            body: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    player1InfoLandscape(
                        mediaQuery.size.height / 2.5, game.player1, game),
                    player4InfoLandscape(
                        mediaQuery.size.height / 2.5, game.player4, game),
                  ],
                ),
                Container(
                  height: mediaQuery.size.height,
                  width: mediaQuery.size.height,
                  child: gameBoard(mediaQuery.size.height, game),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    player2InfoLandscape(
                        mediaQuery.size.height / 2.5, game.player2, game),
                    player3InfoLandscape(
                        mediaQuery.size.height / 2.5, game.player3, game),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class GameScreenMobilePortrait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Consumer<LudoGame>(builder: (context, game, child) {
      return WillPopScope(
        onWillPop: () async {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: appLemon,
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Are you sure you want to leave the game? ',
                        style: mainMenuButtonTextStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: appBlue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4))),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Yes',
                            style: playerNameDisplay.copyWith(
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        },
                      )
                    ],
                  ),
                );
              });
          return false;
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: appBlue,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    player1InfoPortrait(
                        mediaQuery.size.width / 2.5, game.player1, game),
                    player2InfoPortrait(
                        mediaQuery.size.width / 2.5, game.player2, game),
                  ],
                ),
                Container(
                  width: mediaQuery.size.width,
                  height: mediaQuery.size.width,
                  child: gameBoard(mediaQuery.size.width, game),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    player4InfoPortrait(
                        mediaQuery.size.width / 2.5, game.player4, game),
                    player3InfoPortrait(
                        mediaQuery.size.width / 2.5, game.player3, game),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

Widget player1InfoLandscape(
    double playerInfoSize, LudoPlayer player, LudoGame game) {
  double picSize = playerInfoSize / 4;
  double diceSize = playerInfoSize / 3;
  double infoSize = playerInfoSize / 2;
  return Container(
    height: playerInfoSize,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: picSize,
              width: picSize,
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: !player.playing ? null : player.playerImage,
            ),
            Container(
              width: infoSize,
              height: infoSize / 4,
              alignment: Alignment.centerRight,
              child: Padding(
                  padding: EdgeInsets.all(2),
                  child: !player.playing
                      ? null
                      : Text(
                          player.playerName,
                          style: playerNameDisplay.copyWith(
                              fontSize: infoSize / 10),
                        )),
            ),
          ],
        ),
        DiceButton(
          diceSize: diceSize,
          player: player,
        ),
      ],
    ),
  );
}

Widget player2InfoLandscape(
    double playerInfoSize, LudoPlayer player, LudoGame game) {
  double picSize = playerInfoSize / 4;
  double diceSize = playerInfoSize / 3;
  double infoSize = playerInfoSize / 2;
  return Container(
    height: playerInfoSize,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: picSize,
              width: picSize,
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.green,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: !player.playing ? null : player.playerImage,
            ),
            Container(
              width: infoSize,
              height: infoSize / 4,
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.all(2),
                  child: !player.playing
                      ? null
                      : Text(
                          player.playerName,
                          style: playerNameDisplay.copyWith(
                              fontSize: infoSize / 10),
                        )),
            ),
          ],
        ),
        DiceButton(player: player, diceSize: diceSize),
      ],
    ),
  );
}

Widget player3InfoLandscape(
    double playerInfoSize, LudoPlayer player, LudoGame game) {
  double picSize = playerInfoSize / 4;
  double diceSize = playerInfoSize / 3;
  double infoSize = playerInfoSize / 2;
  return Container(
    height: playerInfoSize,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DiceButton(player: player, diceSize: diceSize),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: infoSize,
              height: infoSize / 4,
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.all(2),
                  child: !player.playing
                      ? null
                      : Text(
                          player.playerName,
                          style: playerNameDisplay.copyWith(
                              fontSize: infoSize / 10),
                        )),
            ),
            Container(
              height: picSize,
              width: picSize,
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.yellow,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: !player.playing ? null : player.playerImage,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget player4InfoLandscape(
    double playerInfoSize, LudoPlayer player, LudoGame game) {
  double picSize = playerInfoSize / 4;
  double diceSize = playerInfoSize / 3;
  double infoSize = playerInfoSize / 2;
  return Container(
    height: playerInfoSize,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        DiceButton(player: player, diceSize: diceSize),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: infoSize,
              height: infoSize / 4,
              alignment: Alignment.centerRight,
              child: Padding(
                  padding: EdgeInsets.all(2),
                  child: !player.playing
                      ? null
                      : Text(
                          player.playerName,
                          style: playerNameDisplay.copyWith(
                              fontSize: infoSize / 10),
                        )),
            ),
            Container(
              height: picSize,
              width: picSize,
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.red,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: !player.playing ? null : player.playerImage,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget player1InfoPortrait(
    double playerInfoSize, LudoPlayer player, LudoGame game) {
  double picSize = playerInfoSize / 4;
  double diceSize = playerInfoSize / 3;
  double infoSize = playerInfoSize * 2 / 3;
  return Container(
    width: playerInfoSize,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: picSize,
              width: picSize,
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: !player.playing ? null : player.playerImage,
            ),
            Container(
              width: infoSize,
              height: infoSize / 4,
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.all(2),
                  child: !player.playing
                      ? null
                      : Text(
                          player.playerName,
                          style: playerNameDisplay.copyWith(
                              fontSize: infoSize / 15),
                        )),
            ),
          ],
        ),
        DiceButton(player: player, diceSize: diceSize),
      ],
    ),
  );
}

Widget player2InfoPortrait(
    double playerInfoSize, LudoPlayer player, LudoGame game) {
  double picSize = playerInfoSize / 4;
  double diceSize = playerInfoSize / 3;
  double infoSize = playerInfoSize * 2 / 3;
  return Container(
    width: playerInfoSize,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        DiceButton(player: player, diceSize: diceSize),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: picSize,
              width: picSize,
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.green,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: !player.playing ? null : player.playerImage,
            ),
            Container(
              width: infoSize,
              height: infoSize / 4,
              alignment: Alignment.centerRight,
              child: Padding(
                  padding: EdgeInsets.all(2),
                  child: !player.playing
                      ? null
                      : Text(
                          player.playerName,
                          style: playerNameDisplay.copyWith(
                              fontSize: infoSize / 15),
                        )),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget player3InfoPortrait(
    double playerInfoSize, LudoPlayer player, LudoGame game) {
  double picSize = playerInfoSize / 4;
  double diceSize = playerInfoSize / 3;
  double infoSize = playerInfoSize * 2 / 3;
  return Container(
    width: playerInfoSize,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DiceButton(player: player, diceSize: diceSize),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: infoSize,
              height: infoSize / 4,
              alignment: Alignment.centerRight,
              child: Padding(
                  padding: EdgeInsets.all(2),
                  child: !player.playing
                      ? null
                      : Text(
                          player.playerName,
                          style: playerNameDisplay.copyWith(
                              fontSize: infoSize / 15),
                        )),
            ),
            Container(
              height: picSize,
              width: picSize,
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.yellow,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: !player.playing ? null : player.playerImage,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget player4InfoPortrait(
    double playerInfoSize, LudoPlayer player, LudoGame game) {
  double picSize = playerInfoSize / 4;
  double diceSize = playerInfoSize / 3;
  double infoSize = playerInfoSize * 2 / 3;
  return Container(
    width: playerInfoSize,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: infoSize,
              height: infoSize / 4,
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.all(2),
                  child: !player.playing
                      ? null
                      : Text(
                          player.playerName,
                          style: playerNameDisplay.copyWith(
                              fontSize: infoSize / 15),
                        )),
            ),
            Container(
              height: picSize,
              width: picSize,
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.red,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: !player.playing ? null : player.playerImage,
            ),
          ],
        ),
        DiceButton(player: player, diceSize: diceSize),
      ],
    ),
  );
}

Widget gameBoard(double gameBoardSize, LudoGame game) {
  return Column(
    children: [
      Row(
        children: [
          base1(gameBoardSize * 2 / 5, game.player1, game),
          steps1(gameBoardSize / 5, game),
          base2(gameBoardSize * 2 / 5, game.player2, game)
        ],
      ),
      Row(
        children: [
          steps4(gameBoardSize / 5, game),
          home(gameBoardSize / 5, game),
          steps2(gameBoardSize / 5, game)
        ],
      ),
      Row(
        children: [
          base4(gameBoardSize * 2 / 5, game.player4, game),
          steps3(gameBoardSize / 5, game),
          base3(gameBoardSize * 2 / 5, game.player3, game)
        ],
      ),
    ],
  );
}

Widget base1(double baseSize, LudoPlayer player, LudoGame game) {
  var baseColor = Colors.blue;
  return Container(
    decoration: BoxDecoration(
        color: baseColor,
        border: Border.all(
          color: Colors.black,
          width: 0.5,
        )),
    height: baseSize,
    width: baseSize,
    child: Center(
      child: Container(
        color: Colors.white,
        height: baseSize * 2 / 3,
        width: baseSize * 2 / 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BaseButton(piece: player.piece1, player: player),
                BaseButton(piece: player.piece2, player: player),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BaseButton(
                  piece: player.piece3,
                  player: player,
                ),
                BaseButton(piece: player.piece4, player: player),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget base2(double baseSize, LudoPlayer player, LudoGame game) {
  var baseColor = Colors.green;
  return Container(
    height: baseSize,
    width: baseSize,
    decoration: BoxDecoration(
        color: baseColor,
        border: Border.all(
          color: Colors.black,
          width: 0.5,
        )),
    child: Center(
      child: Container(
        color: Colors.white,
        height: baseSize * 2 / 3,
        width: baseSize * 2 / 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BaseButton(piece: player.piece1, player: player),
                BaseButton(
                  piece: player.piece2,
                  player: player,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BaseButton(piece: player.piece3, player: player),
                BaseButton(
                  piece: player.piece4,
                  player: player,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget base3(double baseSize, LudoPlayer player, LudoGame game) {
  var baseColor = Colors.yellow;
  return Container(
    height: baseSize,
    width: baseSize,
    decoration: BoxDecoration(
        color: baseColor,
        border: Border.all(
          color: Colors.black,
          width: 0.5,
        )),
    child: Center(
      child: Container(
        color: Colors.white,
        height: baseSize * 2 / 3,
        width: baseSize * 2 / 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BaseButton(piece: player.piece1, player: player),
                BaseButton(piece: player.piece2, player: player),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BaseButton(piece: player.piece3, player: player),
                BaseButton(piece: player.piece4, player: player),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget base4(double baseSize, LudoPlayer player, LudoGame game) {
  var baseColor = Colors.red;
  return Container(
    height: baseSize,
    width: baseSize,
    decoration: BoxDecoration(
        color: baseColor,
        border: Border.all(
          color: Colors.black,
          width: 0.5,
        )),
    child: Center(
      child: Container(
        color: Colors.white,
        height: baseSize * 2 / 3,
        width: baseSize * 2 / 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BaseButton(piece: player.piece1, player: player),
                BaseButton(piece: player.piece2, player: player),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BaseButton(piece: player.piece3, player: player),
                BaseButton(piece: player.piece4, player: player),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget steps1(double stepsSize, LudoGame game) {
  var stepsColor = Colors.green;
  return Row(
    children: [
      Column(
        children: [
          Container(
            child: StepButton(
              boardPosition: 12,
            ),
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
          ),
          Container(
              child: StepButton(
                boardPosition: 11,
              ),
              width: stepsSize / 3,
              height: stepsSize / 3,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ))),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 0.5)),
            child: StepButton(
              boardPosition: 10,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 9,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 8,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 7,
            ),
          ),
        ],
      ),
      Column(
        children: [
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 13,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: stepsColor,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 59,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: stepsColor,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 60,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: stepsColor,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 61,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: stepsColor,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 62,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: stepsColor,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 63,
            ),
          ),
        ],
      ),
      Column(
        children: [
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 14,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: stepsColor,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 15,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 16,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 17,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 18,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 19,
            ),
          ),
        ],
      ),
    ],
  );
}

Widget steps2(double stepsSize, LudoGame game) {
  var stepsColor = Colors.yellow;
  return Column(
    children: [
      Row(
        children: [
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 20,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 21,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 22,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 23,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 24,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(boardPosition: 25),
          ),
        ],
      ),
      Row(
        children: [
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: stepsColor,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 69,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: stepsColor,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 68,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: stepsColor,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 67,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: stepsColor,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 66,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: stepsColor,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 65,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 26,
            ),
          ),
        ],
      ),
      Row(
        children: [
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 32,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 31,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 30,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 29,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: stepsColor,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 28,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 27,
            ),
          ),
        ],
      ),
    ],
  );
}

Widget steps3(double stepsSize, LudoGame game) {
  var stepsColor = Colors.red;
  return Row(
    children: [
      Column(
        children: [
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 45,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 44,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 43,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 42,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: stepsColor,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 41,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 40,
            ),
          ),
        ],
      ),
      Column(
        children: [
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: stepsColor,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 75,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: stepsColor,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 74,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: stepsColor,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 73,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: stepsColor,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 72,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: stepsColor,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 71,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 39,
            ),
          ),
        ],
      ),
      Column(
        children: [
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 33,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 34,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 35,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 36,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 37,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 38,
            ),
          ),
        ],
      ),
    ],
  );
}

Widget steps4(double stepsSize, LudoGame game) {
  var stepsColor = Colors.blue;
  return Column(
    children: [
      Row(
        children: [
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 1,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: stepsColor,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 2,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 3,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 4,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 5,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 6,
            ),
          ),
        ],
      ),
      Row(
        children: [
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 52,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: stepsColor,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 53,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: stepsColor,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 54,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: stepsColor,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 55,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: stepsColor,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 56,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: stepsColor,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 57,
            ),
          ),
        ],
      ),
      Row(
        children: [
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 51,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 50,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 49,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 48,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 47,
            ),
          ),
          Container(
            width: stepsSize / 3,
            height: stepsSize / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                )),
            child: StepButton(
              boardPosition: 46,
            ),
          ),
        ],
      ),
    ],
  );
}

Widget home(double homeSize, LudoGame game) {
  const divideBy = 1.41422;
  return Container(
    child: ClipRect(
      child: Align(
        alignment: Alignment.center,
        heightFactor: 1 / divideBy,
        widthFactor: 1 / divideBy,
        child: RotationTransition(
          turns: new AlwaysStoppedAnimation(45 / 360),
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.green,
                        border: Border.all(color: Colors.black, width: 0.5)),
                    height: homeSize / divideBy,
                    width: homeSize / divideBy,
                    child: RotationTransition(
                      turns: new AlwaysStoppedAnimation(315 / 360),
                      child: showHomePiece(game.player2),
                      //child: Text(game.player2.getHomeValue().toString())),
                      alignment: Alignment.bottomRight,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        border: Border.all(color: Colors.black, width: 0.5)),
                    height: homeSize / divideBy,
                    width: homeSize / divideBy,
                    child: RotationTransition(
                      turns: new AlwaysStoppedAnimation(315 / 360),
                      child: showHomePiece(game.player1),
                      //child: Text(game.player1.getHomeValue().toString()
                    ),
                    alignment: Alignment.topRight,
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        border: Border.all(
                          color: Colors.black,
                          width: 0.5,
                        )),
                    height: homeSize / divideBy,
                    width: homeSize / divideBy,
                    child: RotationTransition(
                      turns: new AlwaysStoppedAnimation(315 / 360),
                      child: showHomePiece(game.player3),
                      //child: Text(game.player3.getHomeValue().toString())
                    ),
                    alignment: Alignment.bottomLeft,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        border: Border.all(
                          color: Colors.black,
                          width: 0.5,
                        )),
                    height: homeSize / divideBy,
                    width: homeSize / divideBy,
                    child: RotationTransition(
                      turns: new AlwaysStoppedAnimation(315 / 360),
                      child: showHomePiece(game.player4),
                      //child: Text(game.player4.getHomeValue().toString())
                    ),
                    alignment: Alignment.topLeft,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget showHomePiece(LudoPlayer player) {
  int count = player.getHomeValue();
  List<Widget> piecesHere = [];
  for (int i = 1; i <= count; i++) {
    Widget item = new Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: player.playerColor,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black),
      ),
    );
    piecesHere.add(item);
  }
  return Wrap(
    children: piecesHere,
  );
}
