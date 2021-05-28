import 'package:flutter/material.dart';
import 'package:ludo_game_app/enums/constants.dart';
import 'package:ludo_game_app/utils/player.dart';

class LudoGame extends ChangeNotifier {
  LudoGame.startGame(
    this.numberOfPlayers,
    this.player1,
    this.player2,
    this.player3,
    this.player4,
  ) {
    switch (numberOfPlayers) {
      case 2:
        _playersList = [player1, player3];
        player1.playing = true;
        player3.playing = true;
        break;
      case 3:
        _playersList = [player1, player2, player3];
        player1.playing = true;
        player2.playing = true;
        player3.playing = true;
        break;
      case 4:
        _playersList = [player1, player2, player3, player4];
        player1.playing = true;
        player2.playing = true;
        player3.playing = true;
        player4.playing = true;
        break;
      // default:
      //   _playersList = [player1];
      //   player1.playing = true;
    }
    print('Started game');
    //Start the game
    _currentPlayerIndex = 1;
    turnRoll();
  }

  late LudoPlayer currentPlayer;

  final int numberOfPlayers;
  final LudoPlayer player1;
  final LudoPlayer player2;
  final LudoPlayer player3;
  final LudoPlayer player4;

  int _currentPlayerIndex = 0;

  int rolled6 = 0;

  bool gameEnded = false;

  List<LudoPlayer> _playersList = [];
  List<int> safePositions = [2, 10, 15, 23, 28, 36, 41, 49];
  List<int> alivePositions = [];

  // void startGame() {
  //   switch (numberOfPlayers) {
  //     case 2:
  //       _playersList = [player1, player3];
  //       player1.playing = true;
  //       player3.playing = true;
  //       break;
  //     case 3:
  //       _playersList = [player1, player2, player3];
  //       player1.playing = true;
  //       player2.playing = true;
  //       player3.playing = true;
  //       break;
  //     case 4:
  //       _playersList = [player1, player2, player3, player4];
  //       player1.playing = true;
  //       player2.playing = true;
  //       player3.playing = true;
  //       player4.playing = true;
  //       break;
  //     // default:
  //     //   _playersList = [player1];
  //     //   player1.playing = true;
  //   }
  //   print('Started game');
  //   //Start the game
  //   _currentPlayerIndex = 1;
  //   turnRoll();
  // }

//Whose turn is it to roll, enable dice for him.
  void turnRoll() {
    //Select current player
    currentPlayer = _playersList[_currentPlayerIndex - 1];

    print('Current player is ${currentPlayer.playerName}');
    //If current player is playing the game give him control
    if (currentPlayer.playing) {
      //Show dice as enabled in UI
      currentPlayer.hasRolled = false;
      notifyListeners();
      print('${currentPlayer.playerName} is rolling');
    } else {
      nextPlayer();
      print('Skipped player');
    }
  }

  void turnSelect() {
    //Count number of times the player rolled 6
    if (currentPlayer.diceValue == 6) {
      rolled6 += 1;
    }
    //If player rolled 6 a third time, skip turn
    if (rolled6 == 3) {
      nextPlayer();
    } else {
      //Show selectable pieces for the player on UI
      if (!setSelectablePieces(currentPlayer, currentPlayer.diceValue)) {
        notifyListeners();
        print('${currentPlayer.playerName} cannot select a piece');
        nextPlayer();
      } else {
        notifyListeners();
        print('${currentPlayer.playerName} is selecting a piece now');
      }
    }
  }

  void turnMove() {
    //bool playAgain = false;
    //If player has selected a piece, move it
    bool playAgain = movePiece(currentPlayer, currentPlayer.selectedPieceIndex,
        currentPlayer.diceValue);
    print(
        '${currentPlayer.playerName} completed moving piece${currentPlayer.selectedPieceIndex}');
    currentPlayer.unselectAllPieces();
    notifyListeners();
    //If all pieces reach home, player wins and should be removed from players list
    if (currentPlayer.getHomeValue() == 4) {
      _playersList.remove(currentPlayer);
      _currentPlayerIndex -= 1;
      notifyListeners();
      nextPlayer();
    }
    //If a piece reached home or killed an enemy piece or current player rolled a 6, player gets another turn
    else if (playAgain || currentPlayer.diceValue == 6) {
      turnRoll();
    } else {
      nextPlayer();
    }
  }

  bool movePiece(LudoPlayer player, int movingPiece, int diceValue) {
    //if its piece 1
    if (movingPiece == 1) {
      //If its a dead piece and player rolled 6, summon it
      if (player.piece1.pieceState == LudoPieceState.Dead) {
        player.piece1.pieceState = LudoPieceState.Alive;
        player.piece1.stepPosition = player.startPosition;
        return true;
      }

      //If piece is not of player 1 (blue), make it go around
      if (player != player1 &&
          player.piece1.stepPosition <= 52 &&
          player.piece1.stepPosition + diceValue > 52) {
        player.piece1.stepPosition -= 52;
      }

      //make player 2 (green) move towards home
      if (player == player2 &&
          player.piece1.stepPosition < 14 &&
          player.piece1.stepPosition + diceValue > 13) {
        player.piece1.stepPosition += 45;
      }

      //make player 3 (yellow) move towards home
      if (player == player3 &&
          player.piece1.stepPosition < 27 &&
          player.piece1.stepPosition + diceValue > 26) {
        player.piece1.stepPosition += 38;
      }

      //make player 4 (red) move towards home
      if (player == player4 &&
          player.piece1.stepPosition < 40 &&
          player.piece1.stepPosition + diceValue > 39) {
        player.piece1.stepPosition += 31;
      }

      //Now, move the piece
      player.piece1.stepPosition += diceValue;

      //If piece reaches home, change its state
      if (player.piece1.stepPosition == player.homePosition) {
        player.piece1.pieceState = LudoPieceState.Home;
        return true;
      }

      //Is any other player's piece already there?
      for (LudoPlayer enemy in _playersList) {
        //Check it is an enemy and not the current player
        if (enemy != player) {
          //Check the position is not a safe position
          if (!safePositions.contains(player.piece1.stepPosition)) {
            //Check the enemy doesnt have more than 2 pieces in that position
            if (player.piece1.stepPosition == enemy.piece1.stepPosition &&
                (enemy.piece1.stepPosition != enemy.piece2.stepPosition &&
                    enemy.piece1.stepPosition != enemy.piece3.stepPosition &&
                    enemy.piece1.stepPosition != enemy.piece4.stepPosition)) {
              enemy.piece1.pieceState = LudoPieceState.Dead;
              enemy.piece1.stepPosition = 0;
              return true;
            }
            if (player.piece1.stepPosition == enemy.piece2.stepPosition &&
                (enemy.piece2.stepPosition != enemy.piece1.stepPosition &&
                    enemy.piece2.stepPosition != enemy.piece3.stepPosition &&
                    enemy.piece2.stepPosition != enemy.piece4.stepPosition)) {
              enemy.piece2.pieceState = LudoPieceState.Dead;
              enemy.piece2.stepPosition = 0;
              return true;
            }
            if (player.piece1.stepPosition == enemy.piece3.stepPosition &&
                (enemy.piece3.stepPosition != enemy.piece1.stepPosition &&
                    enemy.piece3.stepPosition != enemy.piece2.stepPosition &&
                    enemy.piece3.stepPosition != enemy.piece4.stepPosition)) {
              enemy.piece3.pieceState = LudoPieceState.Dead;
              enemy.piece3.stepPosition = 0;
              return true;
            }
            if (player.piece1.stepPosition == enemy.piece4.stepPosition &&
                (enemy.piece4.stepPosition != enemy.piece1.stepPosition &&
                    enemy.piece4.stepPosition != enemy.piece2.stepPosition &&
                    enemy.piece4.stepPosition != enemy.piece3.stepPosition)) {
              enemy.piece4.pieceState = LudoPieceState.Dead;
              enemy.piece4.stepPosition = 0;
              return true;
            }
          }
        }
      }
    }

    //If its piece 2
    else if (movingPiece == 2) {
      //If its a dead piece and player rolled 6, summon it
      if (player.piece2.pieceState == LudoPieceState.Dead) {
        player.piece2.pieceState = LudoPieceState.Alive;
        player.piece2.stepPosition = player.startPosition;
        return true;
      }
      //If piece is not of player 1 (blue), make it go around
      if (player != player1 &&
          player.piece2.stepPosition <= 52 &&
          player.piece2.stepPosition + diceValue > 52) {
        player.piece2.stepPosition -= 52;
      }

      //make player 2 (green) move towards home
      if (player == player2 &&
          player.piece2.stepPosition < 14 &&
          player.piece2.stepPosition + diceValue > 13) {
        player.piece2.stepPosition += 45;
      }

      //make player 3 (yellow) move towards home
      if (player == player3 &&
          player.piece2.stepPosition < 27 &&
          player.piece2.stepPosition + diceValue > 26) {
        player.piece2.stepPosition += 38;
      }

      //make player 4 (red) move towards home
      if (player == player4 &&
          player.piece2.stepPosition < 40 &&
          player.piece2.stepPosition + diceValue > 39) {
        player.piece2.stepPosition += 31;
      }

      //Now, move the piece
      player.piece2.stepPosition += diceValue;

      //If piece reaches home, change its state
      if (player.piece2.stepPosition == player.homePosition) {
        player.piece2.pieceState = LudoPieceState.Home;
        return true;
      }

      //Is any other player's piece already there?
      for (LudoPlayer enemy in _playersList) {
        //Check it is an enemy and not the current player
        if (enemy != player) {
          //Check the position is not a safe position
          if (!safePositions.contains(player.piece2.stepPosition)) {
            //Check the enemy doesnt have more than 2 pieces in that position
            if (player.piece2.stepPosition == enemy.piece1.stepPosition &&
                (enemy.piece1.stepPosition != enemy.piece2.stepPosition &&
                    enemy.piece1.stepPosition != enemy.piece3.stepPosition &&
                    enemy.piece1.stepPosition != enemy.piece4.stepPosition)) {
              enemy.piece1.pieceState = LudoPieceState.Dead;
              enemy.piece1.stepPosition = 0;
              return true;
            }
            if (player.piece2.stepPosition == enemy.piece2.stepPosition &&
                (enemy.piece2.stepPosition != enemy.piece1.stepPosition &&
                    enemy.piece2.stepPosition != enemy.piece3.stepPosition &&
                    enemy.piece2.stepPosition != enemy.piece4.stepPosition)) {
              enemy.piece2.pieceState = LudoPieceState.Dead;
              enemy.piece2.stepPosition = 0;
              return true;
            }
            if (player.piece2.stepPosition == enemy.piece3.stepPosition &&
                (enemy.piece3.stepPosition != enemy.piece1.stepPosition &&
                    enemy.piece3.stepPosition != enemy.piece2.stepPosition &&
                    enemy.piece3.stepPosition != enemy.piece4.stepPosition)) {
              enemy.piece3.pieceState = LudoPieceState.Dead;
              enemy.piece3.stepPosition = 0;
              return true;
            }
            if (player.piece2.stepPosition == enemy.piece4.stepPosition &&
                (enemy.piece4.stepPosition != enemy.piece1.stepPosition &&
                    enemy.piece4.stepPosition != enemy.piece2.stepPosition &&
                    enemy.piece4.stepPosition != enemy.piece3.stepPosition)) {
              enemy.piece4.pieceState = LudoPieceState.Dead;
              enemy.piece4.stepPosition = 0;
              return true;
            }
          }
        }
      }
    }

    //If its piece 3
    else if (movingPiece == 3) {
      //If its a dead piece and player rolled 6, summon it
      if (player.piece3.pieceState == LudoPieceState.Dead) {
        player.piece3.pieceState = LudoPieceState.Alive;
        player.piece3.stepPosition = player.startPosition;
        return true;
      }
      //If piece is not of player 1 (blue), make it go around
      if (player != player1 &&
          player.piece3.stepPosition <= 52 &&
          player.piece3.stepPosition + diceValue > 52) {
        player.piece3.stepPosition -= 52;
      }

      //make player 2 (green) move towards home
      if (player == player2 &&
          player.piece3.stepPosition < 14 &&
          player.piece3.stepPosition + diceValue > 13) {
        player.piece3.stepPosition += 45;
      }

      //make player 3 (yellow) move towards home
      if (player == player3 &&
          player.piece3.stepPosition < 27 &&
          player.piece3.stepPosition + diceValue > 26) {
        player.piece3.stepPosition += 38;
      }

      //make player 4 (red) move towards home
      if (player == player4 &&
          player.piece3.stepPosition < 40 &&
          player.piece3.stepPosition + diceValue > 39) {
        player.piece3.stepPosition += 31;
      }

      //Now, move the piece
      player.piece3.stepPosition += diceValue;

      //If piece reaches home, change its state
      if (player.piece3.stepPosition == player.homePosition) {
        player.piece3.pieceState = LudoPieceState.Home;
        return true;
      }

      //Is any other player's piece already there?
      for (LudoPlayer enemy in _playersList) {
        //Check it is an enemy and not the current player
        if (enemy != player) {
          //Check the position is not a safe position
          if (!safePositions.contains(player.piece3.stepPosition)) {
            //Check the enemy doesnt have more than 2 pieces in that position
            if (player.piece3.stepPosition == enemy.piece1.stepPosition &&
                (enemy.piece1.stepPosition != enemy.piece2.stepPosition &&
                    enemy.piece1.stepPosition != enemy.piece3.stepPosition &&
                    enemy.piece1.stepPosition != enemy.piece4.stepPosition)) {
              enemy.piece1.pieceState = LudoPieceState.Dead;
              enemy.piece1.stepPosition = 0;
              return true;
            }
            if (player.piece3.stepPosition == enemy.piece2.stepPosition &&
                (enemy.piece2.stepPosition != enemy.piece1.stepPosition &&
                    enemy.piece2.stepPosition != enemy.piece3.stepPosition &&
                    enemy.piece2.stepPosition != enemy.piece4.stepPosition)) {
              enemy.piece2.pieceState = LudoPieceState.Dead;
              enemy.piece2.stepPosition = 0;
              return true;
            }
            if (player.piece3.stepPosition == enemy.piece3.stepPosition &&
                (enemy.piece3.stepPosition != enemy.piece1.stepPosition &&
                    enemy.piece3.stepPosition != enemy.piece2.stepPosition &&
                    enemy.piece3.stepPosition != enemy.piece4.stepPosition)) {
              enemy.piece3.pieceState = LudoPieceState.Dead;
              enemy.piece3.stepPosition = 0;
              return true;
            }
            if (player.piece3.stepPosition == enemy.piece4.stepPosition &&
                (enemy.piece4.stepPosition != enemy.piece1.stepPosition &&
                    enemy.piece4.stepPosition != enemy.piece2.stepPosition &&
                    enemy.piece4.stepPosition != enemy.piece3.stepPosition)) {
              enemy.piece4.pieceState = LudoPieceState.Dead;
              enemy.piece4.stepPosition = 0;
              return true;
            }
          }
        }
      }
    }

    //If its piece 4
    else if (movingPiece == 4) {
      //If its a dead piece and player rolled 6, summon it
      if (player.piece4.pieceState == LudoPieceState.Dead) {
        player.piece4.pieceState = LudoPieceState.Alive;
        player.piece4.stepPosition = player.startPosition;
        return true;
      }
      //If piece is not of player 1 (blue), make it go around
      if (player != player1 &&
          player.piece4.stepPosition <= 52 &&
          player.piece4.stepPosition + diceValue > 52) {
        player.piece4.stepPosition -= 52;
      }

      //make player 2 (green) move towards home
      if (player == player2 &&
          player.piece4.stepPosition < 14 &&
          player.piece4.stepPosition + diceValue > 13) {
        player.piece4.stepPosition += 45;
      }

      //make player 3 (yellow) move towards home
      if (player == player3 &&
          player.piece4.stepPosition < 27 &&
          player.piece4.stepPosition + diceValue > 26) {
        player.piece4.stepPosition += 38;
      }

      //make player 4 (red) move towards home
      if (player == player4 &&
          player.piece4.stepPosition < 40 &&
          player.piece4.stepPosition + diceValue > 39) {
        player.piece4.stepPosition += 31;
      }

      //Now, move the piece
      player.piece4.stepPosition += diceValue;

      //If piece reaches home, change its state
      if (player.piece4.stepPosition == player.homePosition) {
        player.piece4.pieceState = LudoPieceState.Home;
        return true;
      }

      //Is any other player's piece already there?
      for (LudoPlayer enemy in _playersList) {
        //Check it is an enemy and not the current player
        if (enemy != player) {
          //Check the position is not a safe position
          if (!safePositions.contains(player.piece4.stepPosition)) {
            //Check the enemy doesnt have more than 2 pieces in that position
            if (player.piece4.stepPosition == enemy.piece1.stepPosition &&
                (enemy.piece1.stepPosition != enemy.piece2.stepPosition &&
                    enemy.piece1.stepPosition != enemy.piece3.stepPosition &&
                    enemy.piece1.stepPosition != enemy.piece4.stepPosition)) {
              enemy.piece1.pieceState = LudoPieceState.Dead;
              enemy.piece1.stepPosition = 0;
              return true;
            }
            if (player.piece4.stepPosition == enemy.piece2.stepPosition &&
                (enemy.piece2.stepPosition != enemy.piece1.stepPosition &&
                    enemy.piece2.stepPosition != enemy.piece3.stepPosition &&
                    enemy.piece2.stepPosition != enemy.piece4.stepPosition)) {
              enemy.piece2.pieceState = LudoPieceState.Dead;
              enemy.piece2.stepPosition = 0;
              return true;
            }
            if (player.piece4.stepPosition == enemy.piece3.stepPosition &&
                (enemy.piece3.stepPosition != enemy.piece1.stepPosition &&
                    enemy.piece3.stepPosition != enemy.piece2.stepPosition &&
                    enemy.piece3.stepPosition != enemy.piece4.stepPosition)) {
              enemy.piece3.pieceState = LudoPieceState.Dead;
              enemy.piece3.stepPosition = 0;
              return true;
            }
            if (player.piece4.stepPosition == enemy.piece4.stepPosition &&
                (enemy.piece4.stepPosition != enemy.piece1.stepPosition &&
                    enemy.piece4.stepPosition != enemy.piece2.stepPosition &&
                    enemy.piece4.stepPosition != enemy.piece3.stepPosition)) {
              enemy.piece4.pieceState = LudoPieceState.Dead;
              enemy.piece4.stepPosition = 0;
              return true;
            }
          }
        }
      }
    }
    return false;
  }

  void nextPlayer() {
    //Give dice to next player
    _currentPlayerIndex += 1;
    rolled6 = 0;
    //If it was last player in list go around the list
    if (_currentPlayerIndex > _playersList.length) _currentPlayerIndex = 1;

    //If a player has not reached home, keep playing
    if (_playersList.length > 1) {
      print('Next turn');
      turnRoll();
    } else {
      //TODO: If all but 1 player reach home, stop the game in UI
      print('Game ended!');
      gameEnded = true;
    }
  }

  // void endGame() {
  //   //showDialog(context: context, builder: builder)
  // }

  bool setSelectablePieces(LudoPlayer player, int diceValue) {
    bool playerCanSelect = false;
    if (player.piece1.pieceState == LudoPieceState.Alive) {
      if (player.piece1.stepPosition + diceValue <= player.homePosition) {
        player.piece1.selectable = true;
        print('${player.playerName} piece 1 selectable');
        playerCanSelect = true;
      }
    } else if (player.piece1.pieceState == LudoPieceState.Dead) {
      if (diceValue == 6) {
        player.piece1.selectable = true;
        print('${player.playerName} piece 1 selectable');
        playerCanSelect = true;
      }
    }

    if (player.piece2.pieceState == LudoPieceState.Alive) {
      if (player.piece2.stepPosition + diceValue <= player.homePosition) {
        player.piece2.selectable = true;
        print('${player.playerName} piece 2 selectable');

        playerCanSelect = true;
      }
    } else if (player.piece2.pieceState == LudoPieceState.Dead) {
      if (diceValue == 6) {
        player.piece2.selectable = true;
        print('${player.playerName} piece 2 selectable');

        playerCanSelect = true;
      }
    }

    if (player.piece3.pieceState == LudoPieceState.Alive) {
      if (player.piece3.stepPosition + diceValue <= player.homePosition) {
        player.piece3.selectable = true;
        print('${player.playerName} piece 3 selectable');

        playerCanSelect = true;
      }
    } else if (player.piece3.pieceState == LudoPieceState.Dead) {
      if (diceValue == 6) {
        player.piece3.selectable = true;
        print('${player.playerName} piece 3 selectable');

        playerCanSelect = true;
      }
    }

    if (player.piece4.pieceState == LudoPieceState.Alive) {
      if (player.piece4.stepPosition + diceValue <= player.homePosition) {
        player.piece4.selectable = true;
        print('${player.playerName} piece 4 selectable');

        playerCanSelect = true;
      }
    } else if (player.piece4.pieceState == LudoPieceState.Dead) {
      if (diceValue == 6) {
        player.piece4.selectable = true;
        print('${player.playerName} piece 4 selectable');

        playerCanSelect = true;
      }
    }
    return playerCanSelect;
  }
}
