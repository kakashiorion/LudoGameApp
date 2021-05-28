import 'package:flutter/material.dart';
import 'package:ludo_game_app/enums/constants.dart';
import 'package:ludo_game_app/utils/game.dart';
import 'package:ludo_game_app/utils/player.dart';
import 'package:provider/provider.dart';

class BaseButton extends StatefulWidget {
  const BaseButton({Key? key, required this.piece, required this.player})
      : super(key: key);

  final LudoPiece piece;
  final LudoPlayer player;

  @override
  _BaseButtonState createState() => _BaseButtonState();
}

class _BaseButtonState extends State<BaseButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LudoGame>(builder: (context, game, child) {
      return AnimatedContainer(
        duration: Duration(seconds: 1),
        curve: Curves.bounceInOut,
        height: MediaQuery.of(context).size.shortestSide / 15,
        width: MediaQuery.of(context).size.shortestSide / 15,
        decoration: BoxDecoration(
          color: widget.piece.pieceState == LudoPieceState.Dead
              ? widget.player.playerColor
              : Colors.white,
          shape: BoxShape.circle,
          border: (widget.piece.selectable &&
                  widget.piece.pieceState == LudoPieceState.Dead)
              ? Border.all(color: appYellow, width: 5)
              : Border.all(color: Colors.black),
        ),
        child: MaterialButton(
          onPressed: (widget.piece.pieceState == LudoPieceState.Dead &&
                  widget.piece.selectable)
              ? () {
                  //Mark this piece as selected
                  if (game.currentPlayer.piece1 == widget.piece) {
                    game.currentPlayer.selectedPieceIndex = 1;
                  }
                  if (game.currentPlayer.piece2 == widget.piece) {
                    game.currentPlayer.selectedPieceIndex = 2;
                  }
                  if (game.currentPlayer.piece3 == widget.piece) {
                    game.currentPlayer.selectedPieceIndex = 3;
                  }
                  if (game.currentPlayer.piece4 == widget.piece) {
                    game.currentPlayer.selectedPieceIndex = 4;
                  }
                  print(
                      '${game.currentPlayer.playerName} is moving piece ${game.currentPlayer.selectedPieceIndex} out of base');
                  //setState(() {
                  game.turnMove();
                  //game.currentPlayer.unselectAllPieces();
                  //});
                }
              : null,
        ),
      );
    });
  }
}
