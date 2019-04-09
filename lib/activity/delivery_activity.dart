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
import 'package:stowaway_application/activity/pay_activity.dart';
import 'package:stowaway_application/activity/startscreen.dart';
import 'package:stowaway_application/common/Connectivity.dart';
import 'package:stowaway_application/common/Constants.dart';
import 'package:stowaway_application/common/CustomProgressDialog.dart';
import 'package:stowaway_application/common/UserPreferences.dart';

class DeliveryActivity extends StatefulWidget {

  @override
  _DeliveryActivityState createState() => _DeliveryActivityState();
  String picklocation,destination;
  DeliveryActivity(this.picklocation,this.destination);
}

class _DeliveryActivityState extends State<DeliveryActivity> {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  String userId;
  Response response;
  String reply;

  TextEditingController wiethController = new TextEditingController();
  TextEditingController comodity = new TextEditingController();
  TextEditingController recivername = new TextEditingController();
  TextEditingController reemail = new TextEditingController();
  TextEditingController recmobile = new TextEditingController();

  String _first_name,
      _mobile,
      _email,
      user_token,
      Commodity,
      weight,
      Price,
      Receving_Address,
      Delivery_Address,
      Recevier_Phone,
      Recevier_Name,
      Recevier_Email;
  var map, ownerMap;
  bool _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreferences();
  }
  void _performLogin() {
    //  _incrementCounter(_email);
    try {
      if (wiethController.text.isEmpty) {
        Fluttertoast.showToast(
            msg: "Enter Weight",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
      } else  if (comodity.text.isEmpty) {
        Fluttertoast.showToast(
            msg: "Enter Commodity",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (recivername.text.isEmpty) {
        Fluttertoast.showToast(
            msg: "Enter Reciver Name",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (reemail.text.isEmpty) {
        Fluttertoast.showToast(
            msg: "Enter Your email",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (recmobile.text.isEmpty) {
        Fluttertoast.showToast(
            msg: "Enter Your Number",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
      int  value = int.tryParse('${wiethController.text}');
      int  total =value *10;
        String url = Constants.BASE_URL + Constants.PLACE_ORDER;
        Map map = {
          "User_id": userId,
          "Commodity": comodity.text,
          "Receving_Address": '${widget.picklocation}',
          "Delivery_Address": '${widget.destination}',
          "Giver_Name": _first_name,
          "Giver_Phone": _mobile,
          "Recevier_Phone": recmobile.text,
          "Recevier_Name": recivername.text,
          "Recevier_Email": reemail.text,
          "Weight": wiethController.text,
          "Price": total,

        };

        apiRequest(url, map,user_token,wiethController.text);
      }
    } catch (e) {
      print(e.toString());
    }

  }
  Future<String> apiRequest(String url, Map jsonMap,String tokenAuth,String weigth) async {
    try {
      CustomProgressLoader.showLoader(context);

      var isConnect = await ConectionDetecter.isConnected();
      if (isConnect) {
        HttpClient httpClient = new HttpClient();
        HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
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
        /*  Fluttertoast.showToast(
              msg: "Booked",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0);*/
         // startPayment();
          Navigator.pushReplacement(context,
              new MaterialPageRoute(builder: (BuildContext context) => PayActivity(weigth)));

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
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
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
      user_token = prefs.getString(UserPreferences.USER_TOKEN);
      print('userID'+userId+" : "+_first_name+" : "+_email+" : "+_mobile);
    });

  }


  @override
  Widget build(BuildContext context) {
    final comodit =   new  Padding(
      padding: EdgeInsets.only(top: 10.0),
      child:new Container(
        child:
      TextFormField(
      controller: comodity,
      keyboardType: TextInputType.text,

      decoration: InputDecoration(
        hintText: 'Commodity',


        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
      ),
        margin: new EdgeInsets.all(15.0),
      ),
    );

      final recivernam =   new  Padding(
        padding: EdgeInsets.only(top: 10.0),
        child:new Container(
          child: TextFormField(
      controller: recivername,
      keyboardType: TextInputType.text,

      decoration: InputDecoration(
        hintText: 'Reciver Name',


        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
      ),   margin: new EdgeInsets.all(15.0),
        ),
    );

      final recieveremail =  new  Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: new Container(child: TextFormField(
      controller: reemail,
      keyboardType: TextInputType.emailAddress,

      decoration: InputDecoration(
        hintText: 'Reciver Email',


        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
      ),
          margin: new EdgeInsets.all(15.0),
        ),
    );

      final recievermobile =  new  Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: new Container(child:
          TextFormField(
      controller: recmobile,
      keyboardType: TextInputType.number,

      decoration: InputDecoration(
        hintText: 'Reciver Mobile',


        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
      ),
          margin: new EdgeInsets.all(15.0),
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
                    margin: new EdgeInsets.all(15.0),
                         child: new Text("3-5 Hours",
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
              child:  new  Text('${widget.picklocation}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,),
                ),),
                ),
                  new Container(
                    padding:EdgeInsets.all(12.0),

                    child: new SizedBox(
                      width: double.infinity,
                      child:      new  Text('${widget.destination}',
                  maxLines: 2,
                        overflow: TextOverflow.ellipsis,

                        style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,),
                ),
                ),
                ),

                      new Row(children: <Widget>[
                        new Expanded(
                          child: new Container(
                            padding:EdgeInsets.all(12.0),
                            child: new SizedBox(
                              width: double.infinity,
                              child:         Text("Approx. Weight(KG)",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,),
                              ),
                            ),
                          ),
                        ),
                        new Expanded(

                          child: new  Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child:Container(
                            child:   TextFormField(
                              controller: wiethController,
                              keyboardType: TextInputType.number,

                              decoration: InputDecoration(


                                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              ),
                            ),
                                margin: new EdgeInsets.all(15.0),

                          ),
                        ),
                        ),
                      ]),
                      comodit,
                      recivernam,
                      recieveremail,
                      recievermobile

              ],),)
                  ,),
                  ),
              new Container(
                  child: new SizedBox(
                    width: double.infinity,
                    child:  new FloatingActionButton(
                      onPressed:() {
                   _performLogin();
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
                      child:       Text("NOTE : This  is an approximate  estimate. Actual time  and fares  may very  slightly  based  on traffic or discount",
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
