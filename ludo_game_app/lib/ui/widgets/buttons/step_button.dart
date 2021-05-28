import 'package:flutter/material.dart';
import 'package:ludo_game_app/enums/constants.dart';
import 'package:ludo_game_app/ui/screens/home_screen/home_screen.dart';
import 'package:ludo_game_app/utils/game.dart';
import 'package:provider/provider.dart';

class StepButton extends StatefulWidget {
  const StepButton({Key? key, required this.boardPosition}) : super(key: key);

  final int boardPosition;

  @override
  _StepButtonState createState() => _StepButtonState();
}

class _StepButtonState extends State<StepButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LudoGame>(builder: (context, game, child) {
      return MaterialButton(
        child: displayPieces(game),
        color: selectableStep(game) ? Colors.black12 : null,
        padding: EdgeInsets.all(0),
        onPressed: canMoveOnPress(game)
            ? () {
                moveOnPress(game);
                print(
                    '${game.currentPlayer.playerName} is moving piece ${game.currentPlayer.selectedPieceIndex} from board position ${widget.boardPosition}');
                game.turnMove();
                if (game.gameEnded) {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: appLemon,
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'GAME OVER',
                                style: mainMenuButtonTextStyle,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: appBlue,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4))),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    'Go to Home',
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
                }
              }
            : null,
      );
    });
  }

  bool selectableStep(LudoGame game) {
    return (game.currentPlayer.piece1.stepPosition == widget.boardPosition &&
            game.currentPlayer.piece1.selectable ||
        game.currentPlayer.piece2.stepPosition == widget.boardPosition &&
            game.currentPlayer.piece2.selectable ||
        game.currentPlayer.piece3.stepPosition == widget.boardPosition &&
            game.currentPlayer.piece3.selectable ||
        game.currentPlayer.piece4.stepPosition == widget.boardPosition &&
            game.currentPlayer.piece4.selectable);
  }

  Widget displayPieces(LudoGame game) {
    List<Color> pieceColors = [];
    if (game.player1.piece1.stepPosition == widget.boardPosition) {
      pieceColors.add(game.player1.playerColor);
    }
    if (game.player1.piece2.stepPosition == widget.boardPosition) {
      pieceColors.add(game.player1.playerColor);
    }
    if (game.player1.piece3.stepPosition == widget.boardPosition) {
      pieceColors.add(game.player1.playerColor);
    }
    if (game.player1.piece4.stepPosition == widget.boardPosition) {
      pieceColors.add(game.player1.playerColor);
    }
    if (game.player2.piece1.stepPosition == widget.boardPosition) {
      pieceColors.add(game.player2.playerColor);
    }
    if (game.player2.piece2.stepPosition == widget.boardPosition) {
      pieceColors.add(game.player2.playerColor);
    }
    if (game.player2.piece3.stepPosition == widget.boardPosition) {
      pieceColors.add(game.player2.playerColor);
    }
    if (game.player2.piece4.stepPosition == widget.boardPosition) {
      pieceColors.add(game.player2.playerColor);
    }
    if (game.player3.piece1.stepPosition == widget.boardPosition) {
      pieceColors.add(game.player3.playerColor);
    }
    if (game.player3.piece2.stepPosition == widget.boardPosition) {
      pieceColors.add(game.player3.playerColor);
    }
    if (game.player3.piece3.stepPosition == widget.boardPosition) {
      pieceColors.add(game.player3.playerColor);
    }
    if (game.player3.piece4.stepPosition == widget.boardPosition) {
      pieceColors.add(game.player3.playerColor);
    }
    if (game.player4.piece1.stepPosition == widget.boardPosition) {
      pieceColors.add(game.player4.playerColor);
    }
    if (game.player4.piece2.stepPosition == widget.boardPosition) {
      pieceColors.add(game.player4.playerColor);
    }
    if (game.player4.piece3.stepPosition == widget.boardPosition) {
      pieceColors.add(game.player4.playerColor);
    }
    if (game.player4.piece4.stepPosition == widget.boardPosition) {
      pieceColors.add(game.player4.playerColor);
    }

    //If no piece in this board position, show nothing
    if (pieceColors.length == 0) {
      if (game.safePositions.contains(widget.boardPosition)) {
        //Just show safe Icon if its a safePosition
        return Icon(
          safeStepIcon,
          color: Colors.grey,
          size: MediaQuery.of(context).size.shortestSide / 30,
        );
      } else if (widget.boardPosition == 13) {
        return Icon(
          Icons.keyboard_arrow_down,
          color: Colors.green,
          size: MediaQuery.of(context).size.shortestSide / 30,
        );
      } else if (widget.boardPosition == 26) {
        return Icon(
          Icons.keyboard_arrow_left,
          color: Colors.yellow,
          size: MediaQuery.of(context).size.shortestSide / 30,
        );
      } else if (widget.boardPosition == 39) {
        return Icon(
          Icons.keyboard_arrow_up,
          color: Colors.red,
          size: MediaQuery.of(context).size.shortestSide / 30,
        );
      } else if (widget.boardPosition == 52) {
        return Icon(
          Icons.keyboard_arrow_right,
          color: Colors.blue,
          size: MediaQuery.of(context).size.shortestSide / 30,
        );
      } else {
        return Container();
      }
    }
    //If only 1 piece there, show it as a circle
    else if (pieceColors.length == 1) {
      return AnimatedContainer(
        duration: Duration(seconds: 1),
        curve: Curves.bounceInOut,
        height: MediaQuery.of(context).size.shortestSide / 30,
        width: MediaQuery.of(context).size.shortestSide / 30,
        decoration: BoxDecoration(
          color: pieceColors[0],
          shape: BoxShape.circle,
          border: selectableStep(game)
              ? Border.all(color: Colors.black12, width: 2)
              : Border.all(color: Colors.black),
        ),
        child: game.safePositions.contains(widget.boardPosition)
            ? Icon(
                safeStepIconOccupied,
                color: Colors.grey,
                size: MediaQuery.of(context).size.shortestSide / 40,
              )
            : null,
      );
    }
    //If more than 1 pieces here, show their numbers in colors
    else {
      return Wrap(
        children: createMultiStep(pieceColors),
      );
    }
  }

  List<Widget> createMultiStep(List<Color> list) {
    List<Widget> piecesHere = [];
    // int red = 0;
    // int blue = 0;
    // int green = 0;
    // int yellow = 0;
    for (Color element in list) {
      Widget item = new Container(
        height: MediaQuery.of(context).size.shortestSide /
            (list.length > 4 ? 80 : 60),
        width: MediaQuery.of(context).size.shortestSide /
            (list.length > 4 ? 80 : 60),
        decoration: BoxDecoration(
          color: element,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black),
        ),
      );
      piecesHere.add(item);
    }
    return piecesHere;
  }

  bool canMoveOnPress(LudoGame game) {
    //If one of the player's piece is here and selectable, mark it selected on press
    if (game.currentPlayer.piece1.stepPosition == widget.boardPosition &&
        game.currentPlayer.piece1.selectable) {
      // game.currentPlayer.selectedPieceIndex = 1;
      return true;
    }
    if (game.currentPlayer.piece2.stepPosition == widget.boardPosition &&
        game.currentPlayer.piece2.selectable) {
      //game.currentPlayer.selectedPieceIndex = 2;
      return true;
    }
    if (game.currentPlayer.piece3.stepPosition == widget.boardPosition &&
        game.currentPlayer.piece3.selectable) {
      //game.currentPlayer.selectedPieceIndex = 3;
      return true;
    }
    if (game.currentPlayer.piece4.stepPosition == widget.boardPosition &&
        game.currentPlayer.piece4.selectable) {
      //game.currentPlayer.selectedPieceIndex = 4;
      return true;
    }
    //Else return false and don't move anything
    return false;
  }

  void moveOnPress(LudoGame game) {
    //Mark the piece to move when selected by the user
    if (game.currentPlayer.piece1.stepPosition == widget.boardPosition &&
        game.currentPlayer.piece1.selectable) {
      game.currentPlayer.selectedPieceIndex = 1;
      return;
    } else if (game.currentPlayer.piece2.stepPosition == widget.boardPosition &&
        game.currentPlayer.piece2.selectable) {
      game.currentPlayer.selectedPieceIndex = 2;
      return;
    } else if (game.currentPlayer.piece3.stepPosition == widget.boardPosition &&
        game.currentPlayer.piece3.selectable) {
      game.currentPlayer.selectedPieceIndex = 3;
      return;
    } else if (game.currentPlayer.piece4.stepPosition == widget.boardPosition &&
        game.currentPlayer.piece4.selectable) {
      game.currentPlayer.selectedPieceIndex = 4;
      return;
    }
  }
}
