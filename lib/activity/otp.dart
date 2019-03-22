import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:convert' show json;
import "package:http/http.dart" as http;

class Otp extends StatefulWidget {
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  String _contactText;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  String userId;

//  SharedPreferences prefs;

  String _name;
  var map, ownerMap;
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _performLogin() {
    //  _incrementCounter(_email);
    try {
      // registrationTask(_mobile);
    } catch (e) {
      print(e.toString());
    }
  }

  registrationTask(String mobile) async {
    print("BegnignEMshjsg");

    //   var isConnect = await ConectionDetecter.isConnected();
    //   if (isConnect) {
    //  CustomProgressLoader.showLoader(context);
    print("FirstStep");

    var dio = new Dio();
    dio.options.baseUrl = "https://floating-brushlands-52313.herokuapp.com/authentication";
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 5000;
    dio.options.headers = {'user-agent': 'dio'};
    print("SecondStep");
    // Prepare Data
    FormData formData = new FormData.from({

      "mobile": "96918898081234234",
      "password": "qwerty@123"
      // "mn": "9713172282"
    });

    print("CHAL_GAYA_BHAI");
    // Make API call
    Response response;
    // Send FormData
    response = await dio.post("/loginWebService", data: formData);
    print(response);

    print("--------RES  " + response.data);
    //   CustomProgressLoader.cancelLoader(context);
    if (response.statusCode == 200) {
      setState(() => _isLoading = false);

      map = json.decode(response.data.toString());

      String responce = map["response"];
      if (responce == "success") {
        Fluttertoast.showToast(
            msg: "Register Succesfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);

        /*   Navigator.pushReplacement(
              context,
              new MaterialPageRoute(
                  builder: (BuildContext context) => OtpActivity()));*/
      } else {
        Fluttertoast.showToast(
            msg: "Number Not Register",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      setState(() => _isLoading = false);
      // If that call was not successful, throw an error.

      Fluttertoast.showToast(
          msg: "Please check your internet connection....!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      throw Exception('Something went wrong!!');
    }
    /*} else {
      CustomProgressLoader.cancelLoader(context);

      Fluttertoast.showToast(
          msg: "Please check your internet connection....!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }*/
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('images/logo.png'),
      ),
    );

    final otpEditText = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Otp',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final verifyButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          // Navigator.of(context).pushNamed(Login());
 /*         Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (BuildContext context) => HomePage()));*/
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Verify', style: TextStyle(color: Colors.white)),
      ),
    );

    final resendButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          print("asdfgsdgdsdfgda");
        },
        /*onPressed: () {
          // Navigator.of(context).pushNamed(Login());
          _handleSignIn();
        },*/
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Resend', style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Otp'),
        backgroundColor: Colors.lightBlue,
      ),
      backgroundColor: Colors.white,
      body:
          /* new Stack(children: <Widget>[
        new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("images/banner.jpg"),
              fit: BoxFit.cover,
            ),
          ),

        ),*/
          new Center(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              logo,
              SizedBox(height: 48.0),
              otpEditText,
              SizedBox(height: 24.0),
              verifyButton,
              resendButton
            ],
          ),
        ),
        //   ),
        //],
      ),
    );
  }
}
