import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:stowaway_application/activity/forgot.dart';
import 'package:stowaway_application/activity/startscreen.dart';
import 'dart:async';
import 'package:stowaway_application/common/Connectivity.dart';
import 'package:stowaway_application/common/Constants.dart';
import 'package:stowaway_application/common/CustomProgressDialog.dart';
import 'package:stowaway_application/common/UserPreferences.dart';
import 'package:stowaway_application/navigation_drawer/home_pages.dart';
import 'dart:io';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String _contactText,reply;
  Response response;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  String userId;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  SharedPreferences prefs;

  String _mobile, _password;
  var map, ownerMap;
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  void _performLogin() async{
    try {
      final result1 = await
      SimplePermissions.getPermissionStatus(Permission.AccessFineLocation);
      print("permission status is Ankit :"+result1.toString());
      bool result = await SimplePermissions.checkPermission(Permission.AccessFineLocation);
      if (result==false){
        bool result = (await SimplePermissions.requestPermission( Permission.AccessFineLocation)) as bool;
        print("request :"+ result.toString());
        print("permission is "+ result.toString());

      }else{



      final form = formKey.currentState;

    if (form.validate()) {
      form.save();

      try {
        String url =Constants.BASE_URL +Constants.LOGIN_URL;

        Map map = {

          "Password":_password,
          "Email":_mobile
        };
          apiRequest(url, map);
      } catch (e) {
        print(e.toString());
      }

    }
      }
    } catch (e) {
      print(e.toString());
    }
    void checkpermission() async{
      bool result = await SimplePermissions.checkPermission(Permission.AccessFineLocation);
      if (result==false){
        bool result = (await SimplePermissions.requestPermission( Permission.AccessFineLocation)) as bool;
        print("request :"+ result.toString());
      }else{
      }
      print("permission is "+ result.toString());
    }
    Future<bool> requestPermission() async{

    }
    void getstatus() async{
      final result = await
      SimplePermissions.getPermissionStatus(Permission.AccessFineLocation);
      print("permission status is :"+result.toString());
    }
    /*
    final snackbar = SnackBar(
    content: Text('Email: $_email, password: $_password'),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
    */
  }

  Future<String> apiRequest(String url, Map jsonMap) async {
    try {
      CustomProgressLoader.showLoader(context);
      prefs = await SharedPreferences.getInstance();
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

        print('RESPONCE_DATA : '+status);

        CustomProgressLoader.cancelLoader(context);

        if (status == "3") {
          Fluttertoast.showToast(
              msg: "Email Not Verified",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0);

          return reply;
        } else  if (status == "1") {
            String token = data['key'];
            prefs.setString(UserPreferences.USER_TOKEN, token);

            getDataApi(Constants.BASE_URL +Constants.PROFILE_URL, token);
          return  reply;
        }else  if (status == "2") {
          Fluttertoast.showToast(
              msg: "Email Not Registered/Verified",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0);
        }else  if (status == "4") {
          Fluttertoast.showToast(
              msg: "Incorrect Email And Password",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0);
        }else   {
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

  Future<String> getDataApi(String url,String token) async {
    try {
      CustomProgressLoader.showLoader(context);
      prefs = await SharedPreferences.getInstance();
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
          prefs.setString(UserPreferences.USER_ID, _id);
          prefs.setString(UserPreferences.USER_MOBILE, MobileNo);
          prefs.setString(UserPreferences.USER_NAME, Name);
          prefs.setString(UserPreferences.USER_EMAIL, Email);
          prefs.setString(UserPreferences.USER_FCM, device_id);
          prefs.setString(UserPreferences.LOGIN_STATUS, "TRUE");

          Fluttertoast.showToast(
              msg: "Successfully logged in",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.pushReplacement(context,
              new MaterialPageRoute(builder: (BuildContext context) => HomePage()));
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
  Future<bool> _onWillPop() {
    Navigator.pushReplacement(context,
        new MaterialPageRoute(builder: (BuildContext context) => StartScreen()));

  /*  return showDialog(
      context: context,
      child: new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Unsaved data will be lost.'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    ) ?? false;*/
  }

  @override
  Widget build(BuildContext context) {


    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black26),
      ),
      onPressed: () {
        Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext context) => Forgot()));
      },
    );



    return new WillPopScope(
        onWillPop: _onWillPop,
        child:new  Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.orange,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: new SingleChildScrollView(
            child: new Column(
              children: <Widget>[
                   TextFormField(
                  decoration: InputDecoration(labelText: 'EMAIL *'),
                  validator: (valueMobile) =>
              //    valueMobile.length == 0 ? 'Please Enter Email' : null,
                     !valueMobile.contains('@') ? 'Not a valid email.' : null,
                  onSaved: (valueMobile) => _mobile = valueMobile,
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'PASSWORD *'),
                  validator: (valuePassword) =>
                  valuePassword.length < 6 ? 'Password too short.' : null,
                  onSaved: (valuePassword) => _password = valuePassword,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                ),

                new Container(
                  child: new SizedBox(
                      width: double.infinity,
                    child: new RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      onPressed: _performLogin,
                      textColor: Colors.white,
                      child: new Text("LOGIN"),
                      color: Colors.black87,
                      padding: new EdgeInsets.all(20.0),
                    ),
                    ),
                    margin: new EdgeInsets.only(top: 25)
                ),
                SizedBox(height: 48.0),
                forgotLabel
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }

}
