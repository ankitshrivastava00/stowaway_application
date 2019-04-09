import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stowaway_application/activity/delivery_activity.dart';
import 'package:flutter_places_dialog/flutter_places_dialog.dart';

const kGoogleApiKey = "AIzaSyCarZg-pjH3T-d8XHqdfK_3dBPCtCn9m-w";
//GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  String pickUpLocation = 'Enter Your Pick Up Location',destinationUpLocation = 'Enter Your Destination Location';
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  GoogleMapController mapController;
  bool isLoading = false;
  String errorMessage;
  PlaceDetails _place,_destinationPlace;

  Location _locationService  = new Location();
  bool _permission = false;
  String error;

  bool currentWidget = true;

  Image image1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FlutterPlacesDialog
        .setGoogleApiKey("AIzaSyCarZg-pjH3T-d8XHqdfK_3dBPCtCn9m-w");
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  showPlacePicker() async {
    PlaceDetails place;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      place = await FlutterPlacesDialog.getPlacesDialog();
    } on PlatformException {
      place = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    print("$place");
    setState(() {
      _place = place;
      if (_place == null) {
        pickUpLocation = 'Enter Your Pick Up Location';
      } else {
        pickUpLocation = _place.address;
      }

    });
  }// Platform messages are asynchronous, so we initialize in an async method.
  showDestinationPlacePicker() async {

    PlaceDetails place;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      place = await FlutterPlacesDialog.getPlacesDialog();
    } on PlatformException {
      place = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    print("$place");
    setState(() {
      _destinationPlace = place;
      if (_destinationPlace == null){
        destinationUpLocation = 'Enter Your Destination Location';
      }else{
        destinationUpLocation = _destinationPlace.address;
      }
    });
  }
/*  new GestureDetector(
      onTap: () {

        showPlacePicker();      },
      child:TextFormField(
      controller: emailController,
      keyboardType: TextInputType.text,

      decoration: InputDecoration(
        hintText: 'Enter Your Pick Up Location',
        fillColor: Colors.white,
        filled: true,

        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      obscureText: false,
     // enabled: false,
    ),
    );*/
/*TextFormField(
      controller: passwordController,
      keyboardType: TextInputType.text,

      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: 'Enter Your Destination Location',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );*/


  Widget build(BuildContext context) {


    final pickLocation =
    new InkWell(
      onTap: () => showPlacePicker(),
      child: new Container(
        //width: 100.0,
        height: 40.0,

        decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border.all(color: Colors.black, width: 1.0),
          borderRadius: new BorderRadius.circular(5.0),


        ),

        child:  new Center(child: new Text('${pickUpLocation}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,

          style: new TextStyle(fontSize: 15.0, color: Colors.black54,),
        ),
      ),
      ),
    );

    final destinationLocation =   new InkWell(
      onTap: () => showDestinationPlacePicker(),
      child: new Container(
        //width: 100.0,
        height: 40.0,
        decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border.all(color: Colors.black, width: 1.0),
          borderRadius: new BorderRadius.circular(5.0),

        ),
        child: new Center(
          child :new Text('${destinationUpLocation}',
          maxLines: 1,
            overflow: TextOverflow.ellipsis,

          style: new TextStyle(fontSize: 15.0, color: Colors.black54),),
      ),
      ),
    );
    return Scaffold(

      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            options: GoogleMapOptions(
              trackCameraPosition: true,
              myLocationEnabled: true,
              cameraPosition:
              const CameraPosition(target: LatLng(0.0, 0.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new Expanded(
                    child: new Align(
                      alignment: FractionalOffset.topCenter,
                      child: Column(children: <Widget>[
                        new Container(
                          child: new SizedBox(
                            width: double.infinity,

                            child:pickLocation, /*new RaisedButton(
                              onPressed: () {
                                Navigator.push(context,
                                    new MaterialPageRoute(builder: (BuildContext context) => PlaceBookForm()));
                              },
                              textColor: Colors.white,
                              child: new Text("Book Order12"),
                              color: Colors.orange,
                              //           padding: new EdgeInsets.all(15.0),
                            ),*/
                          ),
                              margin: new EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 10.0),
                        ),
                        new Container(
                          child: new SizedBox(
                            width: double.infinity,

                            child:destinationLocation, /*new RaisedButton(
                              onPressed: () {
                                Navigator.push(context,
                                    new MaterialPageRoute(builder: (BuildContext context) => PlaceBookForm()));
                              },
                              textColor: Colors.white,
                              child: new Text("Book Order12"),
                              color: Colors.orange,
                              //    padding: new EdgeInsets.all(15.0),
                            ),*/
                          ),
                             margin: new EdgeInsets.all(10.0)
                        ),
                      ],)
                    ),
                  ),
                  new Expanded(
                    child: new Align(
                      alignment: FractionalOffset.bottomCenter,
                      child:  new Container(
                          child: new SizedBox(
                            width: double.infinity,

                            child: new RaisedButton(
                              onPressed: () {
                            //    if (emailController.text.isEmpty) {
                                if (pickUpLocation == "Enter Your Pick Up Location") {

                                  Fluttertoast.showToast(
                                      msg: "Enter PickUp Address",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIos: 1,
                                      backgroundColor: Colors.grey,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else if (destinationUpLocation == "Enter Your Destination Location") {

                                  Fluttertoast.showToast(
                                      msg: "Enter Destination",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIos: 1,
                                      backgroundColor: Colors.grey,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else {
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible: false,
                                    // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: new Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,

                                            children: <Widget>[

                                              new Expanded(
                                                child: new Container(

                                                  child: new SizedBox(
                                                    child: new Image.asset(
                                                      'images/clock.png',
                                                      width: 30.0,
                                                      height: 30.0,

                                                    ),
                                                  ),
                                                ),
                                              ),
                                              new Expanded(

                                                child: Container(

                                                  child: Text("SELECT TIME",
                                                    style: TextStyle(
                                                      color: Colors.black,


                                                      fontSize: 14.0,),
                                                  ),
                                                  //   margin: EdgeInsets.only(left:8.0),
                                                ),
                                              ),
                                            ]),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: <Widget>[
                                              new Row(children: <Widget>[
                                                new Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .center,
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .center,
                                                  children: <Widget>[
                                                    new Row(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .spaceAround,
                                                      children: <Widget>[
                                                        new Container(
                                                          alignment: AlignmentDirectional
                                                              .bottomCenter,
                                                          padding: EdgeInsets
                                                              .all(12.0),
                                                          child: new SizedBox(
                                                            child: Text(
                                                              "8:00 AM",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .grey,
                                                                fontSize: 20.0,),
                                                            ),
                                                          ),
                                                        ),
                                                        new Column(
                                                          crossAxisAlignment: CrossAxisAlignment
                                                              .center,
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .center,
                                                          children: <Widget>[
                                                            new Container(
                                                              alignment: AlignmentDirectional
                                                                  .bottomCenter,
                                                              padding: EdgeInsets
                                                                  .all(12.0),
                                                              child: new SizedBox(
                                                                child: Text(
                                                                  "10:00 AM",
                                                                  style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize: 20.0,),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text('CANCEL',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12.0,
                                                /* decoration: TextDecoration.underline,
                             decorationColor: Colors.red,
                             decorationStyle: TextDecorationStyle.wavy,*/
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ), FlatButton(
                                            child: Text('GET FARE ESTIMATE',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12.0,
                                                /* decoration: TextDecoration.underline,
                             decorationColor: Colors.red,
                             decorationStyle: TextDecorationStyle.wavy,*/
                                              ),),
                                            onPressed: () {
                                              // registrationTask(_mobile);
                                              Navigator.of(context).pop();

                                              Navigator.push(context,
                                                  new MaterialPageRoute(
                                                      builder: (
                                                          BuildContext context) =>
                                                          DeliveryActivity(
                                                              pickUpLocation,
                                                              destinationUpLocation)));
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              textColor: Colors.white,
                              child: new Text("Book Order"),
                              color: Colors.orange,
                              padding: new EdgeInsets.all(15.0),
                            ),
                          ),
                          margin: new EdgeInsets.all(15.0)),

                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  void refresh() async {
    final center = await getUserLocation();

    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: center == null ? LatLng(0, 0) : center, zoom: 15.0)));
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    refresh();
  }
  Future<LatLng> getUserLocation() async {
    await _locationService.changeSettings(accuracy: LocationAccuracy.HIGH, interval: 1000);
    LocationData location;

    try {
      _permission = await _locationService.requestPermission();
      print("Permission: $_permission");
      if (_permission) {
        location = await _locationService.getLocation();
        print("Location: ${location.latitude} : lango ${location.longitude}");
        final center = LatLng(location.latitude, location.longitude);
        return center;
      }
    } catch(e) {

   //   _currentLocation = null;
      return null;
    }
}
}