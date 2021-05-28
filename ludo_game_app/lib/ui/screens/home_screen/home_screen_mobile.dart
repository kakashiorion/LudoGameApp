import 'package:flutter/material.dart';
import 'package:ludo_game_app/enums/constants.dart';
import 'package:ludo_game_app/ui/screens/game_screen/game_screen.dart';
import 'package:ludo_game_app/ui/screens/settings_screen/settings_screen.dart';
import 'package:ludo_game_app/ui/widgets/buttons/mainmenu_button.dart';

class HomeScreenMobileLandscape extends StatelessWidget {
  HomeScreenMobileLandscape({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Container(
          color: appBlue,
          height: mediaQuery.size.height,
          alignment: Alignment.center,
          child: Center(
            child: Row(
                //mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: mainMenuImage(mediaQuery),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: mainMenuButtonList(context),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}

class HomeScreenMobilePortrait extends StatelessWidget {
  HomeScreenMobilePortrait({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: appBlue,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: mainMenuImage(mediaQuery),
              ),
              Container(
                height: mediaQuery.size.height / 2,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: mainMenuButtonList(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget mainMenuImage(MediaQueryData mediaQuery) {
  return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'images/ludo_text.png',
          height: mediaQuery.size.shortestSide / 5,
        ),
        Image.asset(
          'images/ludo_bg.png',
          height: mediaQuery.size.shortestSide / 5,
        ),
      ]);
}

List<Widget> mainMenuButtonList(context) {
  return [
    MainMenuButtonMobile(
      title: 'Play Now',
      onTap: () {
        //Pop up asking for number of players
        showDialog(
            context: context,
            builder: (context) {
              return SelectNumberOfPlayers();
            });
      },
    ),
    MainMenuButtonMobile(
      title: 'Settings',
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SettingsScreen()));
      },
    ),
    // MainMenuButtonMobile(
    //   title: 'Help',
    //   onTap: () {
    //     Navigator.push(
    //         context, MaterialPageRoute(builder: (context) => PreGameScreen()));
    //   },
    // )
  ];
}

// ignore: must_be_immutable
class SelectNumberOfPlayers extends StatefulWidget {
  int numberOfPlayers = 0;
  @override
  _SelectNumberOfPlayersState createState() => _SelectNumberOfPlayersState();
}

class _SelectNumberOfPlayersState extends State<SelectNumberOfPlayers> {
  int selectedRadio = 2;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: appBlue,
      elevation: 15,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Select number of Players:',
            style: mainMenuButtonTextStyle,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Radio(
                  value: 2,
                  groupValue: selectedRadio,
                  onChanged: (value) {
                    setState(() {
                      selectedRadio = 2;
                    });
                  },
                ),
                Text(
                  '2',
                  style: playerNameDisplay.copyWith(
                      fontSize: MediaQuery.of(context).size.shortestSide / 20),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 20,
                ),
                Radio(
                  value: 3,
                  groupValue: selectedRadio,
                  onChanged: (value) {
                    setState(() {
                      selectedRadio = 3;
                    });
                  },
                ),
                Text(
                  '3',
                  style: playerNameDisplay.copyWith(
                      fontSize: MediaQuery.of(context).size.shortestSide / 20),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 20,
                ),
                Radio(
                  value: 4,
                  groupValue: selectedRadio,
                  onChanged: (value) {
                    setState(() {
                      selectedRadio = 4;
                    });
                  },
                ),
                Text(
                  '4',
                  style: playerNameDisplay.copyWith(
                      fontSize: MediaQuery.of(context).size.shortestSide / 20),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 10,
          ),
          MainMenuButtonMobile(
            title: 'START!',
            onTap: () {
              widget.numberOfPlayers = selectedRadio;
              if (selectedRadio == 0) {
                Navigator.pop(context);
              } else {
                print('Starting game with $selectedRadio players');
                //START GAME AND GO TO GAME SCREEN
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GameScreen(
                              numberOfPlayers: widget.numberOfPlayers,
                            )));
              }
            },
          )
        ],
      ),
    );
  }
}
