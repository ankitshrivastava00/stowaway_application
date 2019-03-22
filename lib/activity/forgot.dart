//import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';

import 'dart:async';
import 'package:stowaway_application/common/Connectivity.dart';
import 'package:stowaway_application/common/CustomProgressDialog.dart';
import 'dart:io';

class Forgot extends StatefulWidget {
  @override
  _ForgotState createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {

  String reply;
  Response response;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  String userId;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  //SharedPreferences prefs;
  String _email;
  var map, ownerMap;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  void _performLogin() {
    try {final form = formKey.currentState;
    if (form.validate()) {
      form.save();

      try {
        /*apiCallForUserProfile(_first_name,_last_name, _mobile, _email, _city, _address, _state,
          _password, '132134343434343434343');*/
        String url =
            'https://floating-brushlands-52313.herokuapp.com/authentication/'+_email;
      /*  Map map = {
          "Email":_mobile
        };*/

        apiRequest(url);
      } catch (e) {
        print(e.toString());
      }

    }
    } catch (e) {
      print(e.toString());
    }

    /*
     final snackbar = SnackBar(
      content: Text('Email: $_email, password: $_password'),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
    */
  }

  /*getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    userId = prefs.getString(UserPreferences.USER_ID);
  }*/

  Future<String> apiRequest(String url) async {
    try {
      CustomProgressLoader.showLoader(context);

      var isConnect = await ConectionDetecter.isConnected();
      if (isConnect) {
        HttpClient client = new HttpClient();
        client.getUrl(Uri.parse(url))
            .then((HttpClientRequest request) {
          // Optionally set up headers...
          // Optionally write to the request object...
          // Then call close.
        //  ...
          return request.close();
        })
            .then((HttpClientResponse response)  async {
          // Process the response.
          CustomProgressLoader.cancelLoader(context);
          reply = await response.transform(utf8.decoder).join();
          Map data = json.decode(reply);
          String status = data['response'];
          print('RESPONCE_DATA : '+status);
          if(status=="1"){
            Fluttertoast.showToast(
                msg:
                "Check Your Inbox and Verify Your Account",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                backgroundColor: Colors.grey,
                textColor: Colors.white,
                fontSize: 16.0);
            Navigator.of(context).pop();
          }else if(status == "4" ){
            Fluttertoast.showToast(
                msg:
                "Email Id Not register",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                backgroundColor: Colors.grey,
                textColor: Colors.white,
                fontSize: 16.0);
          }

         // ...
        });
      } else {
        CustomProgressLoader.cancelLoader(context);
        Fluttertoast.showToast(
            msg: "Please check your internet connection....!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      CustomProgressLoader.cancelLoader(context);
      print(e);
      return reply;
    }
  }

  @override
  Widget build(BuildContext context) {


    final forgotLabel = FlatButton(
      child: Text(
        "Don't worry! Just Enter Your Number Below"
            "And we'll send  you the  password reset instrucation",
        style: TextStyle(color: Colors.black),
      ),

    );
    final loginButton = Container(
        width: 100.0,
        height: 100.0,
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage('images/emoji.png'),
            fit: BoxFit.fitWidth,
          ),
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

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Forgot Password'),
        backgroundColor: Colors.orange,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: new SingleChildScrollView(
            child: new Column(
              children: <Widget>[
                loginButton,
                forgotLabel,
                   TextFormField(
                  decoration: InputDecoration(labelText: 'EMAIL ID *'),
                  validator: (valueMobile) =>
                  //valueMobile.length != 10 ? 'Enter Correct Number' : null,
                     !valueMobile.contains('@') ? 'Not a valid email.' : null,
                  onSaved: (valueMobile) => _email = valueMobile,
                  keyboardType: TextInputType.emailAddress,
                  //maxLength: 10,
                ),
          /*      new Container(
                  child: new SizedBox(
                      width: double.infinity,
                    child: new RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                     // onPressed: _performLogin,
                      textColor: Colors.white,
                      child: new Text("RESET PASSWORD"),
                      color: Colors.black38,
                      padding: new EdgeInsets.all(20.0),
                    ),
                    ),
                    margin: new EdgeInsets.only(top: 25)
                ),*/

                new Container(
                    child: new SizedBox(
                      width: double.infinity,

                      child: new RaisedButton(
                        onPressed: _performLogin,
                        textColor: Colors.white,
                        child: new Text("RESET PASSWORD"),
                        color: Colors.black87,
                        padding: new EdgeInsets.all(15.0),
                      ),
                    ),
                    margin: new EdgeInsets.all(15.0)
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
