import 'package:flutter/material.dart';

class FirstFragment extends StatelessWidget {
/*  final logo = Hero(
    tag: 'hero',
    child: CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 100.0,
      child: Image.asset('images/background.png'),
    ),
  );
  final logo1 = Hero(
    tag: 'hero',
    child: CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 110.0,
      child: Image.asset('images/background.png'),
    ),
  );*/
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.lightBlue,

      body:
      new Stack(children: <Widget>[
        new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("images/background.png"),
             // fit: BoxFit.fill,
            ),
          ),
        ),
          new Center(child: Center(
    child: ListView(
    shrinkWrap: true,
    children: <Widget>[
      new Text("Hello World"),
   // logo,
    SizedBox(height: 20.0),
  //  logo1,

    ],
    ),
    ),
    ),
      ],
      ),
    );
  }

}