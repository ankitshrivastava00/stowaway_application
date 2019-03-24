import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';
import 'package:razorpay_plugin/razorpay_plugin.dart';
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

class PayActivity extends StatefulWidget {
  @override
  _PayActivityState createState() => _PayActivityState();
  String weigth;
  PayActivity(this.weigth);
}

class _PayActivityState extends State<PayActivity> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  String userId;
  Response response;
  String reply;

//  SharedPreferences prefs;
  int value,total;
  String _first_name,
      _last_name,
      _mobile,
      _email,
      _password;
  var map, ownerMap;
  bool _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreferences();
    setState(() {
      value = int.tryParse('${widget.weigth}');
      total =value *10;
      print('total Value ${total}');
    });

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

  startPayment() async {
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
        title: Text('PAYMENT MODE'),
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
                    margin: new EdgeInsets.all(15.0),
                         child: new Text('${total}',
                           style: TextStyle(
                             color: Colors.white,
                             fontSize: 35.0,
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
                        ),  new Container(
                    margin: new EdgeInsets.all(15.0),
                         child: new Text("DELIVERY COST",
                           style: TextStyle(
                             color: Colors.white,
                             fontSize: 20.0,
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
                        ),

                      ],
                    ),
                  ),
                ],
                ),
              ),
            new Padding(padding: EdgeInsets.all(20.0),child:   new Container(
                  child: new SizedBox(
                    width: double.infinity,
                    child: new RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      onPressed: startPayment,
                      textColor: Colors.white,
                      child: new Text("PAYNOW"),
                      color: Colors.orange,
                      padding: new EdgeInsets.all(20.0),
                    ),
                  ),
                  margin: new EdgeInsets.only(top: 25)
              ,) ),
            ],
            ),
          ),
          // ),
        ),

      ),


    );
  }
}
