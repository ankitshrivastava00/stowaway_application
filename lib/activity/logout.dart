import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:convert' show json;
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stowaway_application/activity/startscreen.dart';
import 'package:stowaway_application/common/UserPreferences.dart';

class Logout extends StatefulWidget {
  @override
  _LogoutState createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logout();
  }


  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(UserPreferences.LOGIN_STATUS, "FALSE");
    Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) =>
                StartScreen()));

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return Scaffold(

      backgroundColor: Colors.white,
      body:
        new Text("Logout"),

    );
  }
}
