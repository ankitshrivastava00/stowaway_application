import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stowaway_application/activity/confirm_activity.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:stowaway_application/activity/otp.dart';
import 'package:stowaway_application/activity/startscreen.dart';
import 'package:stowaway_application/common/Connectivity.dart';
import 'package:stowaway_application/common/Constants.dart';
import 'package:stowaway_application/common/CustomProgressDialog.dart';
import 'package:stowaway_application/common/UserPreferences.dart';

class SelectPaymentActivity extends StatefulWidget {
  @override
  _SelectPaymentActivityState createState() => _SelectPaymentActivityState();
}

class _SelectPaymentActivityState extends State<SelectPaymentActivity> {
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

  getSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      userId = prefs.getString(UserPreferences.USER_ID);
      _first_name = prefs.getString(UserPreferences.USER_NAME);
      _email = prefs.getString(UserPreferences.USER_EMAIL);
      _mobile = prefs.getString(UserPreferences.USER_MOBILE);
      print('userID'+userId+" : "+_first_name+" : "+_email+" : "+_mobile);
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
    final destinationLocation = TextFormField(
      //controller: passwordController,
      keyboardType: TextInputType.text,
      autofocus: true,
      enabled: false,
      enableInteractiveSelection: false,

      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: 'Enter Your Destination Location',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
    return  new  Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Delivery Time Estimate'),
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
                      height: 180.0,
                    ),
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                      color: Colors.orange,
                    ),
                    child:new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Container(
                    margin: new EdgeInsets.all(25.0),
                         child: new Text("10",
                           style: TextStyle(
                             color: Colors.white,
                             fontSize: 25.0,
                            /* decoration: TextDecoration.underline,
                             decorationColor: Colors.red,
                             decorationStyle: TextDecorationStyle.wavy,*/
                           ),),
                         /*   decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                image:new AssetImage('images/man.png'),
                                fit: BoxFit.cover,
                              ),
                            )*/
                        ),   new Container(

                         child: new Text("DELIVERY COST : 20",
                           style: TextStyle(
                             color: Colors.white,
                             fontSize: 15.0,

                           ),
                         ),
                        ),
                      ],
                    ),
                  ),
                ],
                ),
              ),

              new Card(
                child: new Container(
                    child: new SizedBox(
                      width: double.infinity,

                      child: new Column(
                    children: <Widget>[
                  //    destinationLocation,
                  //    pickLocation1,
                 //     pickLocation2,
                      new Container(
                        padding:EdgeInsets.all(12.0),

                        child: new SizedBox(
                        width: double.infinity,
              child:  new  Text("243 Joanie PIne",
                  style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,),
                ),),
                ),
              ],),)
                  ,),
                  ),
              new Container(
                  child: new SizedBox(
                    width: double.infinity,
                    child:  new FloatingActionButton(
                      onPressed:() {
                    Navigator.push(context,
                    new MaterialPageRoute(builder: (BuildContext context) => ConfirmActivity()));
                    },
                      backgroundColor: Colors.orange,
                      child: const Icon(Icons.check, size: 36.0),
                    ),

                  ),

                  margin: new EdgeInsets.all(15.0)),

              new Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new Container(
                    alignment: AlignmentDirectional.bottomCenter,


                    padding:EdgeInsets.all(12.0),
                    child: new SizedBox(
                      child:         Text("NOTE : This  is an approximate  estimate. Actual time  and fares  may very  slightly  based  on traffic or discount",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0,),
                      ),
                    ),
                  ),

                ],
              ),
            ],
            ),
          ),
          // ),

        ),

      ),


    );
  }
}
