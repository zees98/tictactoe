import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

enum MessageType { DRAW, WIN }

class AlertBox extends StatefulWidget {
  final message, type;
  const AlertBox({Key key, this.message, this.type}) : super(key: key);
  @override
  _AlertBoxState createState() => _AlertBoxState();
}

class _AlertBoxState extends State<AlertBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 250),
      child: Material(
        clipBehavior: Clip.hardEdge,
        color: Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide(color: Colors.red, width: 8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Image.asset('assets/win.gif'),
            ),
            Text(widget.message,
                style: TextStyle(color: Colors.white, fontSize: 50)),
          ],
        ),
      ),
    );
  }
}
