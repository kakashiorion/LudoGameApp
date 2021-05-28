import 'package:flutter/material.dart';
import 'package:ludo_game_app/enums/constants.dart';

class LudoPlayer {
  LudoPlayer(
      {required this.playerImage,
      required this.playerName,
      required this.playerColor,
      required this.homePosition,
      required this.startPosition,
      this.hasRolled = true,
      this.diceValue = 1,
      this.playing = false});

  final Image playerImage;
  final String playerName;
  final Color playerColor;
  final int homePosition;
  final int startPosition;
  int diceValue;
  bool playing;
  bool hasRolled;

  int selectedPieceIndex = 0;

  LudoPiece piece1 = new LudoPiece(LudoPieceState.Dead, 0);
  LudoPiece piece2 = new LudoPiece(LudoPieceState.Dead, 0);
  LudoPiece piece3 = new LudoPiece(LudoPieceState.Dead, 0);
  LudoPiece piece4 = new LudoPiece(LudoPieceState.Dead, 0);

  void unselectAllPieces() {
    piece1.selectable = false;
    piece2.selectable = false;
    piece3.selectable = false;
    piece4.selectable = false;
    selectedPieceIndex = 0;
  }

  int getHomeValue() {
    int value = 0;
    if (piece1.pieceState == LudoPieceState.Home) {
      value += 1;
    }
    if (piece2.pieceState == LudoPieceState.Home) {
      value += 1;
    }
    if (piece3.pieceState == LudoPieceState.Home) {
      value += 1;
    }
    if (piece4.pieceState == LudoPieceState.Home) {
      value += 1;
    }
    return value;
  }
}

class LudoPiece {
  LudoPiece(this.pieceState, this.stepPosition);

  LudoPieceState pieceState;
  int stepPosition;
  late Color pieceColor;
  bool selectable = false;
}
