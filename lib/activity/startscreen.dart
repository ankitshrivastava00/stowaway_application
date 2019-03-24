import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:razorpay_plugin/razorpay_plugin.dart';
import 'package:stowaway_application/activity/confirm_activity.dart';
import 'package:stowaway_application/activity/login.dart';
import 'package:stowaway_application/activity/register.dart';

class StartScreen extends StatefulWidget{
  @override
  _StartScreenState createState() => _StartScreenState();
}
class _StartScreenState extends State<StartScreen>{
 /* startPayment() async {
    Map<String, dynamic> options = new Map();
    options.putIfAbsent("name", () => "Stowaway Payment");
    options.putIfAbsent("image", () => "https://www.73lines.com/web/image/12427");
    options.putIfAbsent("description", () => "This is a real transaction");
    options.putIfAbsent("amount", () => "100");
    options.putIfAbsent("email", () => "ankit.shrivastava00@gmail.com");
    options.putIfAbsent("contact", () => "9713172282");
    //Must be a valid HTML color.
    options.putIfAbsent("theme", () => "#FF0000");
    //Notes -- OPTIONAL
    Map<String, String> notes = new Map();
    notes.putIfAbsent('key', () => "value");
    notes.putIfAbsent('randomInfo', () => "haha");
    options.putIfAbsent("notes", () => notes);
    options.putIfAbsent("api_key", () => "rzp_test_xDhZniW6E8lmwa");
    //  options.putIfAbsent("api_key", () => "rzp_live_jvB6dYPSWVYnEp");
    Map<dynamic,dynamic> paymentResponse = new Map();
    paymentResponse = await Razorpay.showPaymentForm(options);
    print("response $paymentResponse");
    String code=paymentResponse['code'];
    if (code == '0'){
      Fluttertoast.showToast(
          msg: "Payment Cancel",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.of(context).pop();


    }else{
      Fluttertoast.showToast(
          msg: "Payment Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pushReplacement(context,
          new MaterialPageRoute(builder: (BuildContext context) => ConfirmActivity()));
    }
  }
 */ @override
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
          Navigator.pushReplacement(
              context,
              new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      Registration()));
        },
        padding: EdgeInsets.all(20),
        color: Colors.black87,
        child: Text('REGISTER', style: TextStyle(color: Colors.white)),
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
        //  startPayment();
          Navigator.pushReplacement(
              context,
              new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      Login()));
        },
        padding: EdgeInsets.all(20),
        color: Colors.white,
        child: Text('LOGIN', style: TextStyle(color: Colors.black)),
      ),
     ),
    );
    Widget middleSection =  new Container (
        child: new Column(
        //  crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
          new Image.asset('images/background.png')
          ],
        ),
   //   ),
    );
    final textLabel = FlatButton(

      child: Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        style: TextStyle(color: Colors.black54,

            fontFamily: 'Roboto:300'),
      ),
    );
    Widget body = new Column(
      // This makes each child fill the full width of the screen
     /* crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,*/
      children: <Widget>[
        middleSection,
        SizedBox(height: 5.0),
        forgotLabel,
        textLabel,
        SizedBox(height: 15.0),

        new Row(
         mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            signUpButton,
            singInButton

          ],
        )
      ],
    );
    return new Scaffold(
      body: new Padding(
        padding: new EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
        child: body,
      ),
    );
  }
}