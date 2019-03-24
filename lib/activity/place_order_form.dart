import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:stowaway_application/activity/otp.dart';
//import 'package:razorpay_plugin/razorpay_plugin.dart';


import 'package:stowaway_application/common/Connectivity.dart';
import 'package:stowaway_application/common/Constants.dart';
import 'package:stowaway_application/common/CustomProgressDialog.dart';
import 'package:stowaway_application/common/UserPreferences.dart';

class PlaceBookForm extends StatefulWidget {
  @override
  _PlaceBookFormState createState() => _PlaceBookFormState();
}

class _PlaceBookFormState extends State<PlaceBookForm> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  String userId,user_token;
  Response response;
  String reply;

//  SharedPreferences prefs;

  String _name,_email,_mobile;


  String User_id,Commodity,Receving_Address,Delivery_Address,Giver_Name,Giver_Phone,Recevier_Phone,Recevier_Name,Recevier_Email,Price,weight,Date;
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
      user_token = prefs.getString(UserPreferences.USER_TOKEN);
      User_id = prefs.getString(UserPreferences.USER_ID);
      _name = prefs.getString(UserPreferences.USER_NAME);
      _email = prefs.getString(UserPreferences.USER_EMAIL);
      _mobile = prefs.getString(UserPreferences.USER_MOBILE);
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
/*
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
    options.putIfAbsent("api_key", () => "rzp_live_jvB6dYPSWVYnEp");
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
      Navigator.of(context).pop();

    }



  }*/

  void _performLogin() async{
    //  _incrementCounter(_email);
    try {

      String url = Constants.BASE_URL + Constants.PLACE_ORDER;
      Map map = {
        "User_id": User_id,
        "Commodity": Commodity,
        "Receving_Address": Receving_Address,
        "Delivery_Address": Delivery_Address,
        "Giver_Name": Giver_Name,
        "Giver_Phone": Giver_Phone,
        "Recevier_Phone": Recevier_Phone,
        "Recevier_Name": Recevier_Name,
        "Recevier_Email": Recevier_Email,
        "Weight": weight,
        "Price": Price,

      };

      apiRequest(url, map,user_token);
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

  Future<String> apiRequest(String url, Map jsonMap,String tokenAuth) async {
    try {
      CustomProgressLoader.showLoader(context);

      var isConnect = await ConectionDetecter.isConnected();
      if (isConnect) {
        HttpClient httpClient = new HttpClient();
        HttpClientRequest request = await httpClient.postUrl(Uri.parse('https://floating-brushlands-52313.herokuapp.com/order/place_order'));
        request.headers.set('Content-Type','Application/json');
        request.headers.set('Authorization','Bearer '+tokenAuth);
        request.add(utf8.encode(json.encode(jsonMap)));
        HttpClientResponse response = await request.close();
        // todo - you should check the response.statusCode
        reply = await response.transform(utf8.decoder).join();
        httpClient.close();
        Map data = json.decode(reply);
        String status = data['response'];

        CustomProgressLoader.cancelLoader(context);
         if (status == "1") {
          Fluttertoast.showToast(
              msg: "Book Successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0);
      //    startPayment();
         /*  Navigator.push(context,
               new MaterialPageRoute(builder: (BuildContext context) => PaymentActivity()));*/
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Book Order'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: new  SingleChildScrollView(
        child: new Column(            //   child: new Column(
            //padding: EdgeInsets.all(25.0),
            children: <Widget>[


       TextFormField(
                    decoration: InputDecoration(labelText: 'Commodity *'),
                    validator: (valueCommodity) =>
                        valueCommodity.length <= 0 ? 'Enter Your Commodity' : null,
                    //   !val.contains('@') ? 'Not a valid email.' : null,
                    onSaved: (valueCommodity) => Commodity = valueCommodity,
                    keyboardType: TextInputType.text,
                  ),


               TextFormField(

                    decoration: InputDecoration(labelText: 'Receving Address *'),

                    validator: (valueReceving_Address) =>
                    valueReceving_Address.length <= 0 ? 'Enter Receving Address' : null,
                    //   !val.contains('@') ? 'Not a valid email.' : null,
                    onSaved: (valueReceving_Address) => Receving_Address = valueReceving_Address,
                    keyboardType: TextInputType.text,
                  ),
                 //   margin: EdgeInsets.only(left:8.0),

              TextFormField(
                decoration: InputDecoration(labelText: 'Delivery Address *'),
                validator: (valueDelivery_Address) =>
                valueDelivery_Address.length <= 0 ? 'Enter Delivery Address' : null,
                  //  !valueEmail.contains('@') ? 'Not a valid email.' : null,
                onSaved: (valueDelivery_Address) => Delivery_Address = valueDelivery_Address,
                keyboardType: TextInputType.emailAddress,
              ),

              TextFormField(
                decoration: InputDecoration(labelText: 'Giver_Name *'),
                validator: (valueGiver_Name) =>
                valueGiver_Name.length <= 0 ? 'Enter Giver Name' : null,

                //    valuePassword.length < 6 ? 'Password too short.' : null,
                onSaved: (valueGiver_Name) => Giver_Name = valueGiver_Name,
                keyboardType: TextInputType.text,
              ),

      TextFormField(
                decoration: InputDecoration(labelText: 'Giver Phone *'),
                validator: (valueGiver_Phone) =>
                valueGiver_Phone.length != 10 ? 'Enter Correct Number' : null,
                //   !val.contains('@') ? 'Not a valid email.' : null,
                onSaved: (valueGiver_Phone) => Giver_Phone = valueGiver_Phone,
                keyboardType: TextInputType.number,
                maxLength: 10,
              ),  TextFormField(
                decoration: InputDecoration(labelText: 'Recevier Phone *'),
                validator: (valueRecevier_Phone) =>
                valueRecevier_Phone.length != 10 ? 'Enter Correct Recevier Number' : null,
                //   !val.contains('@') ? 'Not a valid email.' : null,
                onSaved: (valueRecevier_Phone) => Recevier_Phone = valueRecevier_Phone,
                keyboardType: TextInputType.number,
                maxLength: 10,
              ), TextFormField(
                decoration: InputDecoration(labelText: 'Recevier Name *'),
                validator: (valueRecevier_Name) =>
                valueRecevier_Name.length <= 0 ? 'Enter Recevier  Name' : null,
                //   !val.contains('@') ? 'Not a valid email.' : null,
                onSaved: (valueRecevier_Name) => Recevier_Name = valueRecevier_Name,
                keyboardType: TextInputType.text,
              ),
       TextFormField(
         decoration: InputDecoration(labelText: 'Recevier Email *'),
         validator: (valueRecevier_Email) =>
         // valueDelivery_Address.length <= 0 ? 'Enter Recevier Email' : null,
         !valueRecevier_Email.contains('@') ? 'Not a valid email.' : null,
         onSaved: (valueRecevier_Email) => Recevier_Email = valueRecevier_Email,
         keyboardType: TextInputType.emailAddress,
       ),
       TextFormField(
         decoration: InputDecoration(labelText: 'Price *'),
         validator: (valuePrice) =>
         valuePrice.length <= 0 ? 'Enter Price' : null,
        // !valueRecevier_Email.contains('@') ? 'Not a valid email.' : null,
         onSaved: (valuePrice) => Price = valuePrice,
         keyboardType: TextInputType.number,

       ),

      TextFormField(
         decoration: InputDecoration(labelText: 'weight(kg) *'),
         validator: (valueweight) =>
         valueweight.length <= 0 ? 'Enter weight(kg)' : null,
        // !valueRecevier_Email.contains('@') ? 'Not a valid email.' : null,
         onSaved: (valueweight) => weight = valueweight,
         keyboardType: TextInputType.number,
         maxLength: 5,
       ),

      /* TextFormField(
         decoration: InputDecoration(labelText: 'Date *'),
         validator: (valueDate) =>
         valueDate.length <= 0 ? 'Enter Date' : null,
         //!valueRecevier_Email.contains('@') ? 'Not a valid email.' : null,
         onSaved: (valueDate) => Date = valueDate,
         keyboardType: TextInputType.text,
       ),
*/

              new Container(
                  child: new SizedBox(
                    width: double.infinity,
                    child: new RaisedButton(
                      onPressed: _submit,
                      textColor: Colors.white,
                      child: new Text("BOOK"),
                      color: Colors.black87,
                      padding: new EdgeInsets.all(15.0),
                    ),
                  ),
                  margin: new EdgeInsets.all(15.0)),
            ],
          ),
        ),
        // ),
      ),
      ),
    );
  }
}
