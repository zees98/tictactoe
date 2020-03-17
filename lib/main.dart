import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/alertbox.dart';
import 'package:tic_tac_toe/gameModel.dart';
import 'package:tic_tac_toe/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TIC TAC TOE', theme: ThemeData.dark(), home: SplashScreen());
  }
}

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with SingleTickerProviderStateMixin{
  int _counter = 0;
  bool showGrid = false;
  @override
  Widget build(BuildContext context) {
    GameModel gm = Provider.of<GameModel>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              //Settings Dialog
            },
          )
        ],
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          'TIC TAC TOE',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: <Widget>[
          TweenAnimationBuilder(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: Duration(milliseconds: 800),
            curve: Curves.easeInOutQuad,
            child: Container(
              color: Colors.red.shade800,
            ),
            builder: (context, val, widget) {
              return ClipPath(
                clipper: MyClipper(val),
                child: widget,
              );
            },
          ),
          /*
          ClipPath(
            clipper: SecondClipper(),
            child: Container(
              color: Colors.purpleAccent,
            ),
          ), */
          //(showGrid)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Turn ${gm.turn % 2 == 0 ? 'O' : 'X'}',
                    style: TextStyle(
                      fontSize: 50,
                      fontFamily: 'Indie',
                    ),
                  ),
                ),
              ),
              Expanded(child: Container(),),
              Expanded(
                  flex: 5,
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemCount: 9,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(20)),
                          onPressed: () {
                            //Add User Input to Game Model
                            gm.writeToPosition(index);
                            //Game Draw
                            if (!gm.isWon & gm.win()) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertBox(
                                      message: 'WINNN!!',
                                      type: MessageType.WIN,
                                    );
                                  });
                            } else if (gm.turn == 9)
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertBox(
                                      message: 'DRAW!!',
                                      type: MessageType.DRAW,
                                    );
                                  });
                          },
                          highlightColor: Colors.indigo,
                          color: Colors.transparent,
                          child: Text(
                            gm.gameList[index].toString(),
                            style: TextStyle(fontSize: 50),
                          ),
                        ),
                      );
                    },
                  )),
            ],
          ),
        ],
      ),
      drawer: GameDrawer(),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
          color: Colors.red,
          shape: CircularNotchedRectangle(),
          child: Container(
            height: 60,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: 150,
        child: FloatingActionButton(
          //shape: CircleBorder(side: BorderSide(width: 4)),
          backgroundColor: Colors.redAccent,
          onPressed: () {
            gm.reset();
          },
          child: Icon(
            Icons.settings_backup_restore,
            size: 40,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class GameDrawer extends StatefulWidget {
  @override
  _GameDrawerState createState() => _GameDrawerState();
}

class _GameDrawerState extends State<GameDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipPath(
                  clipper: DrawerClipper(),
                  child: Container(
                    height: 150,
                    color: Colors.red,
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.center,
                  child: DrawerHeader(
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/logo.png',
                          height: 100,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('TIC TAC TOE')
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Manage'),   
              initiallyExpanded: true,           
              children: <Widget>[
                FunctionTiles(
                  icon: Icons.person,
                  title: 'Profile',
                  onPressed: () {},
                ),
                FunctionTiles(
                  icon: Icons.calendar_view_day,
                  title: 'Match History',
                  onPressed: () {},
                ),
                FunctionTiles(
                  icon: Icons.settings,
                  title: 'Settings',
                ),
              ],
            )
            //FunctionTiles(icon: Icons.person, title: 'Profile',),
          ],
        ),
      ),
    );
  }
}

class FunctionTiles extends StatelessWidget {
  final title, icon, onPressed;
  const FunctionTiles({
    Key key,
    this.title,
    this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade900,
      child: ListTile(
        onTap: onPressed,
        title: Text(title),
        trailing: Icon(
          icon,
          color: Colors.purpleAccent,
        ),
      ),
    );
  }
}

class DrawerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path _path = Path();
    _path.lineTo(0, 0);
    _path.lineTo(size.width, 0);
    _path.lineTo(0, size.height);
    _path.close();
    return _path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class MyClipper extends CustomClipper<Path> {
  final fluctuation;

  MyClipper(this.fluctuation);
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path _path = Path();
    print('Fluctuation: $fluctuation');
    //_path.lineTo(0, 0);
    // _path.quadraticBezierTo(size.width * 0.55, size.height * 0.25,size.width / 2, size.height / 2);
    // _path.quadraticBezierTo( size.width * 0.55, size.height * 0.25, size.width, 0);

    _path.quadraticBezierTo(size.width / 2, size.height * 0.35 * fluctuation, size.width, 0);

    //_path.moveTo(0, size);

    // _path.lineTo(0, 0);
    // _path.quadraticBezierTo(
    //   size.width * fluctuation * 0.1,
    //   size.height * 0.2,
    //   size.width / 2,
    //   size.height / 2,
    // );
    // _path.quadraticBezierTo(
    //   size.width * 0.1,
    //   size.height * 0.65,
    //   0,
    //   size.height,
    // );
    // _path.lineTo(0, size.height);

    // _path.quadraticBezierTo(size.width * 0.05, size.height * 0.2,
    //     size.width / 2, size.height * 0.45);
    // _path.quadraticBezierTo(size.width * 0.6, size.height * 0.6,
    //     size.width * 0.8, size.height * 0.5);
    // _path.lineTo(0 , size.height);
    _path.close();

    return _path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}

class SecondClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path _path = Path();
    _path.moveTo(size.width, 0);
    _path.quadraticBezierTo(
        size.width * 0.9, size.height * 0.25, size.width / 2, size.height / 2);
    //_path.lineTo(size.width, size.height);

    _path.quadraticBezierTo(
      size.width * 0.9,
      size.height * (1 - 0.65),
      size.width,
      size.height,
    );
    return _path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
