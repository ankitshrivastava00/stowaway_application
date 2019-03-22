import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:stowaway_application/activity/otp.dart';
import 'package:stowaway_application/activity/startscreen.dart';
import 'package:stowaway_application/common/Connectivity.dart';
import 'package:stowaway_application/common/Constants.dart';
import 'package:stowaway_application/common/CustomProgressDialog.dart';
import 'package:stowaway_application/common/UserPreferences.dart';

class ProfileEdit extends StatefulWidget {
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  String userId;
  Response response;
  String reply;

//  SharedPreferences prefs;

  String _first_name,
      _last_name,
      _mobile,
      _email,
      _password,
      _city,
      _address,
      _state,
      _lat,
      _long,
      _IEMI,
      _deviceId;
  var map, ownerMap;
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreferences();
  }

  Future<String> getDataApi(String url,String token) async {
    try {
      CustomProgressLoader.showLoader(context);
      var isConnect = await ConectionDetecter.isConnected();
      if (isConnect) {
        HttpClient httpClient = new HttpClient();
        HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
        request.headers.set('content-type', 'application/json');
        request.headers.set('Authorization', 'Bearar '+token);
        //   request.add(utf8.encode(json.encode(jsonMap)));
        HttpClientResponse response = await request.close();
        // todo - you should check the response.statusCode
        reply = await response.transform(utf8.decoder).join();
        httpClient.close();
        Map data = json.decode(reply);
        String status = data['response'];

        print('RESPONCE_DATA : '+status);

        CustomProgressLoader.cancelLoader(context);

        if (status == "1") {
          String Name = data['Name'];
          String MobileNo = data['MobileNo'];
          String Email = data['Email'];
          String _id = data['_id'];
          String device_id = data['device_id'];

          return  reply;
        }else     {
          Fluttertoast.showToast(
              msg: "Try Again Some Thing Is Wrong",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0);
        }
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
        // ToastWrap.showToast("Please check your internet connection....!");
        // return response;
      }
    } catch (e) {
      CustomProgressLoader.cancelLoader(context);
      print(e);
      return reply;
    }
  }

  getSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      userId = prefs.getString(UserPreferences.USER_ID);
      _first_name = prefs.getString(UserPreferences.USER_NAME);
      _email = prefs.getString(UserPreferences.USER_EMAIL);
      _mobile = prefs.getString(UserPreferences.USER_MOBILE);
      print('ProfileuserID'+userId+" : "+_first_name+" : "+_email+" : "+_mobile);
    });

  }


  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      // fetchData();
      // Email & password matched our validation rules
      // and are saved to _email and _password fields.
      _performLogin();
    }
  }

  /*_incrementCounter(String mob) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    */ /*int counter = (prefs.getInt('counter') ?? 0) + 1;
    print('Pressed $counter times.');*/ /*
    await prefs.setString("MOBILE", mob);
  }*/
  void _performLogin() {
    //  _incrementCounter(_email);
    try {
      /*apiCallForUserProfile(_first_name,_last_name, _mobile, _email, _city, _address, _state,
          _password, '132134343434343434343');*/
      String url = Constants.BASE_URL + Constants.REGISTRATION_URL;
      Map map = {
        "device_id": "sdrgdfsgsdgsdfg",
        "Name": _first_name + " " + _last_name,
        "Password": _password,
        "MobileNo": _mobile,
        "Email": _email,
        "IMEI": "78787874"
      };

      apiRequest(url, map);
    } catch (e) {
      print(e.toString());
    }

    /* final snackbar = SnackBar(
      content: Text('Email: $_email, password: $_password'),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);*/
  }

/*  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    userId = prefs.getString(UserPreferences.USER_ID);
  }*/

  Future<String> apiRequest(String url, Map jsonMap) async {
    try {
      CustomProgressLoader.showLoader(context);

      var isConnect = await ConectionDetecter.isConnected();
      if (isConnect) {
        HttpClient httpClient = new HttpClient();
        HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
        request.headers.set('content-type', 'application/json');
        request.add(utf8.encode(json.encode(jsonMap)));
        HttpClientResponse response = await request.close();
        // todo - you should check the response.statusCode
        reply = await response.transform(utf8.decoder).join();
        httpClient.close();
        Map data = json.decode(reply);
        String status = data['response'];

        CustomProgressLoader.cancelLoader(context);

        if (status == "0") {
          Fluttertoast.showToast(
              msg:
                  "Succesfully Registered, Please Check Your Inbox and Verify Your Account",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.of(context).pop();
          return reply;
        } else if (status == "1") {
          Fluttertoast.showToast(
              msg: "Details Already Used",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0);
          return reply;
        } else {
          Fluttertoast.showToast(
              msg: "Failed Try Again",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0);
          return reply;
        }
      } else {
        CustomProgressLoader.cancelLoader(context);
        Fluttertoast.showToast(
            msg: "Please Check Your Internet Connection....!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
        // ToastWrap.showToast("Please check your internet connection....!");
        // return response;
      }
    } catch (e) {
      CustomProgressLoader.cancelLoader(context);
      print(e);
      return reply;
    }
  }

  Future<bool> _onWillPop() {
    Navigator.pushReplacement(context,
        new MaterialPageRoute(builder: (BuildContext context) => StartScreen()));


  }

  @override
  Widget build(BuildContext context) {
    return  new  Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Form(
          key: formKey,
          child: new SingleChildScrollView(
            //   child: new Column(
            //padding: EdgeInsets.all(25.0),

            child: new Column(children: <Widget>[

        new  Padding(
          padding: EdgeInsets.only(top: 0.0),
          child: new Stack(fit: StackFit.loose, children: <Widget>[
            new Container(
              constraints: new BoxConstraints.expand(
                height: 150.0,
              ),
              alignment: Alignment.center,
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage('images/profilebackground.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child:new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          image:new AssetImage('images/man.png'),
                          fit: BoxFit.cover,
                        ),
                      )),
                ],
              ),
            ),
],),),

          new  Padding(
            padding: const EdgeInsets.all(16.0),
            child:
              new Row(children: <Widget>[
                new Expanded(
                  child:Container(
                  child: new TextFormField(
                    initialValue: 'Dikshant',

                    decoration: InputDecoration(labelText: 'First Name *'),
                    validator: (valueName) =>
                        valueName.length <= 0 ? 'Enter Your First Name' : null,
                    //   !val.contains('@') ? 'Not a valid email.' : null,
                    onSaved: (valueName) => _first_name = valueName,
                    keyboardType: TextInputType.text,
                  ),
                    margin: EdgeInsets.only(right:8.0),
                ),
                ),
                new Expanded(

                  child:Container(
                    child: TextFormField(
                     initialValue: 'Mahant',

                    decoration: InputDecoration(labelText: 'Last Name *'),

                    validator: (valueName) =>
                        valueName.length <= 0 ? 'Enter Your Last Name' : null,
                    //   !val.contains('@') ? 'Not a valid email.' : null,
                    onSaved: (valueName) => _last_name = valueName,
                    keyboardType: TextInputType.text,
                  ),
                 //   margin: EdgeInsets.only(left:8.0),
                ),
                ),
              ]
              ),
              ),
          new  Padding(
            padding: const EdgeInsets.all(16.0),
            child:

              TextFormField(
                initialValue: 'dikshantmahant@gmail.com',

                decoration: InputDecoration(labelText: 'Email *'),
                validator: (valueEmail) =>
                    //valueEmail.length <= 0 ? 'Enter Your Email' : null,
                    !valueEmail.contains('@') ? 'Not a valid email.' : null,
                onSaved: (valueEmail) => _email = valueEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              ),

          new  Padding(
            padding: const EdgeInsets.all(16.0),
            child:TextFormField(
              initialValue: '9713172282',

              decoration: InputDecoration(labelText: 'Mobile *'),
                validator: (valueMobile) =>
                    valueMobile.length != 10 ? 'Enter Correct Number' : null,
                //   !val.contains('@') ? 'Not a valid email.' : null,
                onSaved: (valueMobile) => _mobile = valueMobile,
                keyboardType: TextInputType.number,
                maxLength: 10,
              ),
              ),
/*
              new Container(
                  child: new SizedBox(
                    width: double.infinity,
                    child: new RaisedButton(
                     // onPressed: _submit,
                      textColor: Colors.white,
                      child: new Text("UPDATE"),
                      color: Colors.orange,
                      padding: new EdgeInsets.all(15.0),
                    ),
                  ),
                  margin: new EdgeInsets.all(15.0)),*/
            ],
          ),
        ),
        // ),

    ),

      ),


    );
  }
}
