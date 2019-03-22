import 'package:flutter/material.dart';

import 'package:stowaway_application/fragment/mapactivity.dart';
import 'package:stowaway_application/navigation_drawer/home_pages.dart';

class Verify extends StatefulWidget{
  @override
  _VerifyState createState() => _VerifyState();
}
class _VerifyState extends State<Verify>{
  @override
  Widget build(BuildContext context) {
    Widget subtitle = new Container (
      padding: new EdgeInsets.all(8.0),
      color: new Color(0X33000000),
      child: new Text('Subtitle'),
    );
    final forgotLabel = FlatButton(
      child: Text('Welcome to Stowaway',
      style: TextStyle(color: Colors.lightBlueAccent,fontSize: 20.0),
      ),
    );
    final singInButton = Container(

      padding: EdgeInsets.all(8.0),
        child: new SizedBox(
          width: 150.0,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
            side: BorderSide(width: 1.0, color: Colors.grey)
        ),
        onPressed: () {
          // Navigator.of(context).pushNamed(Login());
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      HomePage()));
        },
        padding: EdgeInsets.all(20),
        color: Colors.grey,
        child: Text('RESEND CODE', style: TextStyle(color: Colors.white)),
      ),
      ),
    );
    final signUpButton = Container(

      padding: EdgeInsets.all(8.0),
        child: new SizedBox(
       width: 150.0,
        child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(width: 1.0, color: Colors.grey)
        ),
        onPressed: () {
          // Navigator.of(context).pushNamed(Login());
         /* Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      Login()));*/
        },
        padding: EdgeInsets.all(20),
        color: Colors.grey,
        child: Text('CHANGE EMAIL', style: TextStyle(color: Colors.white)),
      ),
     ),
    );
    final loginButton = Container(
      width: 100.0,
      height: 100.0,
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage('images/verify.png'),
          fit: BoxFit.fitWidth,
        ),
      ),
    );
    Widget middleSection =  new Container (
        child: new Column(
        //  crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
          new Image.asset('images/verify.png')
          ],
        ),
   //   ),
    );
    final textLabel = FlatButton(

      child: new Center(child: Text(
        'Please Check your mailbox for the '
            'activation link.I am waiting here for you!',
        style: TextStyle(color: Colors.black54,

            fontFamily: 'Roboto:300'),
      ),
      ),
    );
    Widget body = new Center(
      child: new Column(
      // This makes each child fill the full width of the screen
     /* crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,*/
      children: <Widget>[
        SizedBox(height: 40.0),
        loginButton,
        SizedBox(height: 35.0),

        textLabel,
        SizedBox(height: 80.0),

        new Row(
         mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            signUpButton,
            singInButton

          ],
        )
      ],
    ),
    );
    return new Scaffold(

      appBar: AppBar(
        title: Text('Verify Email'),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.white,
      body: new Padding(
        padding: new EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
        child: body,
      ),
    );
  }
}