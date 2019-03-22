import 'package:flutter/material.dart';

class SecondFragment extends StatelessWidget {
  final logo = Hero(
    tag: 'hero',
    child: CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 100.0,
      child: Image.asset('images/background.png'),
    ),
  );
  final text  = TextFormField (
    autofocus: false,

    obscureText: true,
    decoration: InputDecoration(
      hintText: 'Password',
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
    ),
  );

  final logo1 = Hero(
    tag: 'hero',
    child: CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 110.0,
      child: Image.asset('images/background.png'),
    ),
  );
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      /* appBar: AppBar(
        title: Text('ShuddhH2O'),
        backgroundColor: Colors.lightBlue,
      ),*/
      body:
      new Stack(children: <Widget>[
        new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("images/background.png"),
              fit: BoxFit.fill,
            ),
          ),
        ),

        /*  new GridView.count(
          crossAxisCount: 2,
    children: new List<Widget>.generate(4, (index) {
    return   new Center(child: new GridTile(
    child: new Center(child: new Card(
    color: Colors.lightBlue,
    child: new Center(


      child: new Text('$index Liter'),
    )
    ),
    ),
    ),
    );
    }),
          ),*/
       //   ),
    ],
      ),
    );
  }

}