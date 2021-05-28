import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ludo_game_app/enums/constants.dart';
import 'package:ludo_game_app/utils/game.dart';
import 'package:ludo_game_app/utils/player.dart';
import 'package:provider/provider.dart';

//Function to fetch image to be shown for the dice button
Image getDiceImage(int diceValue) {
  switch (diceValue) {
    case 1:
      return Image.asset('images/dice1.png');
    case 2:
      return Image.asset('images/dice2.png');
    case 3:
      return Image.asset('images/dice3.png');
    case 4:
      return Image.asset('images/dice4.png');
    case 5:
      return Image.asset('images/dice5.png');
    case 6:
      return Image.asset('images/dice6.png');
    default:
      return Image.asset('images/dice1.png');
  }
}

class DiceButton extends StatefulWidget {
  const DiceButton({
    Key? key,
    required this.player,
    required this.diceSize,
  }) : super(key: key);

  final LudoPlayer player;
  final double diceSize;

  @override
  _DiceButtonState createState() => _DiceButtonState();
}

class _DiceButtonState extends State<DiceButton> {
  //Image diceImage = getDiceImage(1);
  @override
  Widget build(BuildContext context) {
    return Consumer<LudoGame>(builder: (context, game, child) {
      return AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.bounceInOut,
        height: widget.diceSize,
        width: widget.diceSize,
        decoration: BoxDecoration(
          border: (widget.player != game.currentPlayer ||
                  game.currentPlayer.hasRolled)
              ? null
              : Border.all(
                  color: appYellow,
                  width: 2,
                ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: (widget.player != game.currentPlayer ||
                  game.currentPlayer.hasRolled)
              ? null
              : [
                  BoxShadow(
                    blurRadius: 5,
                    color: appYellow,
                    spreadRadius: 5,
                  )
                ],
        ),
        child: MaterialButton(
          elevation: 5,
          padding: EdgeInsets.all(0),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: getDiceImage(widget.player.diceValue)),
          onPressed: (widget.player == game.currentPlayer &&
                  !game.currentPlayer.hasRolled)
              ? () {
                  widget.player.diceValue = Random().nextInt(6) + 1;
                  print(
                      '${widget.player.playerName} rolled a ${widget.player.diceValue}');
                  widget.player.hasRolled = true;
                  game.turnSelect();
                }
              : null,
        ),
      );
    });
  }
}
