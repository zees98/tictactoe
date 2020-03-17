import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/gameModel.dart';
import 'package:tic_tac_toe/main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Color _color = Colors.teal.shade900;
  TextStyle _textStyle = TextStyle(fontSize: 20);
  
  Timer _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_color == Colors.teal.shade900) {
        setState(() {
          _color = Colors.black;
        });
      } else {
        setState(() {
          _color = Colors.teal.shade900;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_textStyle.fontSize);
    return Scaffold(
      body: AnimatedContainer(
        curve: Curves.bounceIn,
        color: _color,
        duration: Duration(milliseconds: 900),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TweenAnimationBuilder(
                      curve: Curves.easeInOut,
                      duration: Duration(seconds: 2),
                      tween: Tween(begin: 0.0, end: 1.0),
                      child: Image.asset(
                        'assets/logo.png',
                      ),
                      builder: (context, value, widget) {
                        return SizedBox(
                          height: 200 * value,
                          child: widget,
                        );
                      },
                    ),
                    AnimatedDefaultTextStyle(
                      curve: Curves.easeOutSine,
                      child: Text(
                        'TIC TAC TOE',
                        textAlign: TextAlign.center,
                      ),
                      style: _color == Colors.black
                          ? TextStyle(fontSize: 70, fontFamily: 'Zhi')
                          : TextStyle(fontSize: 50, fontFamily: 'Indie'),
                      duration: Duration(milliseconds: 400),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: FlatButton(
                    onPressed: () {
                      _timer.cancel();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ChangeNotifierProvider.value(
                                    value: GameModel() ,
                                      child: GamePage())));
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    color: Colors.red,
                    child: Text(
                      'Play',
                      style: TextStyle(fontSize: 30, fontFamily: 'Indie'),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print('Disposing');
    super.dispose();
    _timer.cancel();
  }
}
