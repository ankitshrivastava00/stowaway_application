import 'dart:async';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as LocationManager;
import 'package:stowaway_application/activity/delivery_activity.dart';
import 'package:stowaway_application/activity/place_detail.dart';
import 'package:stowaway_application/activity/place_order_form.dart';

const kGoogleApiKey = "AIzaSyCarZg-pjH3T-d8XHqdfK_3dBPCtCn9m-w";
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
/*
void main() {
  runApp(MaterialApp(
    title: "PlaceZ",
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}
*/

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  GoogleMapController mapController;
  List<PlacesSearchResult> places = [];
  bool isLoading = false;
  String errorMessage;
/*
  @override
  Widget build(BuildContext context) {
   *//* Widget expandedChild;
    if (isLoading) {
      expandedChild = Center(child: CircularProgressIndicator(value: null));
    } else if (errorMessage != null) {
      expandedChild = Center(
        child: Text(errorMessage),
      );
    } else {
      expandedChild = buildPlacesList();
    }
*//*
    return Scaffold(
        key: homeScaffoldKey,
       *//* appBar: AppBar(
          title: const Text("PlaceZ"),
          actions: <Widget>[
            isLoading
                ? IconButton(
              icon: Icon(Icons.timer),
              onPressed: () {},
            )
                : IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                refresh();
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                _handlePressButton();
              },
            ),
          ],
        ),*//*
        body: Column(
          children: <Widget>[
            Container(
              child: SizedBox(
                  height: 200.0,
                  child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      options: GoogleMapOptions(
                          myLocationEnabled: true,
                          cameraPosition:
                          const CameraPosition(target: LatLng(0.0, 0.0))))),
            ),
            Expanded(child: expandedChild)
          ],
        ));
  }*/
  Widget build(BuildContext context) {

    final pickLocation =  TextFormField(
      controller: emailController,
      keyboardType: TextInputType.text,

      decoration: InputDecoration(
        hintText: 'Enter Your Pick Up Location',
        fillColor: Colors.white,
        filled: true,

        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );

    final destinationLocation = TextFormField(
      controller: passwordController,
      keyboardType: TextInputType.text,


      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: 'Enter Your Destination Location',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
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
                const CameraPosition(target: LatLng(0.0, 0.0),),
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
                              margin: new EdgeInsets.all(10.0)
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
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible: false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title:  new Row(
                                          mainAxisAlignment: MainAxisAlignment.center,

                                          children: <Widget>[

                                        new Expanded(
                                          child:  new Container(

                                            child: new SizedBox(
                                        child:  new Image.asset(
                                          'images/clock.png',
                                          width: 30.0,
                                          height: 30.0,

                                        ),
                                      ),
                                      ),
                                        ),
                                        new Expanded(

                                          child:Container(

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
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  new Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: <Widget>[
                                        new Container(
                                        alignment: AlignmentDirectional.bottomCenter,
                                          padding:EdgeInsets.all(12.0),
                                          child: new SizedBox(
                                            child:         Text("8:00 AM",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 20.0,),
                                            ),
                                          ),
                                        ),
                                        new Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            new Container(
                                              alignment: AlignmentDirectional.bottomCenter,


                                              padding:EdgeInsets.all(12.0),
                                              child: new SizedBox(
                                                child:         Text("10:00 AM",
                                                  style: TextStyle(
                                                    color: Colors.grey,
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
                                            ],)

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
                                            Navigator.of(context).pop();

                                            Navigator.push(context,
                                                new MaterialPageRoute(builder: (BuildContext context) => DeliveryActivity()));
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                                /*Navigator.push(context,
                                    new MaterialPageRoute(builder: (BuildContext context) => PlaceBookForm()));*/
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
                  /*   Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    RaisedButton(
                      child: Text("Rock & Roll"),
                      color: Colors.red,
                      textColor: Colors.yellow,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      splashColor: Colors.grey,
                    )
                  ],
                ),
              ),
            ),*/
                  /*
                FloatingActionButton(
                onPressed: _onMapTypeButtonPressed,
                materialTapTargetSize: MaterialTapTargetSize.padded,
                backgroundColor: Colors.green,
                child: const Icon(Icons.map, size: 36.0),
                ),
                const SizedBox(height: 16.0),
                FloatingActionButton(
                onPressed: _onAddMarkerButtonPressed,
                materialTapTargetSize: MaterialTapTargetSize.padded,
                backgroundColor: Colors.green,
                child: const Icon(Icons.add_location, size: 36.0),
                ),
                */
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
    getNearbyPlaces(center);
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    refresh();
  }

  Future<LatLng> getUserLocation() async {
    var currentLocation = <String, double>{};
    final location = LocationManager.Location();
    try {
      currentLocation = await location.getLocation();
      final lat = currentLocation["latitude"];
      final lng = currentLocation["longitude"];
      final center = LatLng(lat, lng);
      return center;
    } on Exception {
      currentLocation = null;
      return null;
    }
  }

  void getNearbyPlaces(LatLng center) async {
    setState(() {
      this.isLoading = true;
      this.errorMessage = null;
    });

    final location = Location(center.latitude, center.longitude);
    final result = await _places.searchNearbyWithRadius(location, 2500);
    setState(() {
      this.isLoading = false;
      if (result.status == "OK") {
        this.places = result.results;
        result.results.forEach((f) {
          final markerOptions = MarkerOptions(
              position:
              LatLng(f.geometry.location.lat, f.geometry.location.lng),
              infoWindowText: InfoWindowText("${f.name}", "${f.types?.first}"));
          mapController.addMarker(markerOptions);
        });
      } else {
        this.errorMessage = result.errorMessage;
      }
    });
  }

  void onError(PlacesAutocompleteResponse response) {
    homeScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

  Future<void> _handlePressButton() async {
    try {
      final center = await getUserLocation();
      Prediction p = await PlacesAutocomplete.show(
          context: context,
          strictbounds: center == null ? false : true,
          apiKey: kGoogleApiKey,
          onError: onError,
          mode: Mode.fullscreen,
          language: "en",
          location: center == null
              ? null
              : Location(center.latitude, center.longitude),
          radius: center == null ? null : 10000);

      showDetailPlace(p.placeId);
    } catch (e) {
      return;
    }
  }

  Future<Null> showDetailPlace(String placeId) async {
    if (placeId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PlaceDetailWidget(placeId)),
      );
    }
  }

  ListView buildPlacesList() {
    final placesWidget = places.map((f) {
      List<Widget> list = [
        Padding(
          padding: EdgeInsets.only(bottom: 4.0),
          child: Text(
            f.name,
            style: Theme.of(context).textTheme.subtitle,
          ),
        )
      ];
      if (f.formattedAddress != null) {
        list.add(Padding(
          padding: EdgeInsets.only(bottom: 2.0),
          child: Text(
            f.formattedAddress,
            style: Theme.of(context).textTheme.subtitle,
          ),
        ));
      }

      if (f.vicinity != null) {
        list.add(Padding(
          padding: EdgeInsets.only(bottom: 2.0),
          child: Text(
            f.vicinity,
            style: Theme.of(context).textTheme.body1,
          ),
        ));
      }

      if (f.types?.first != null) {
        list.add(Padding(
          padding: EdgeInsets.only(bottom: 2.0),
          child: Text(
            f.types.first,
            style: Theme.of(context).textTheme.caption,
          ),
        ));
      }

      return Padding(
        padding: EdgeInsets.only(top: 4.0, bottom: 4.0, left: 8.0, right: 8.0),
        child: Card(
          child: InkWell(
            onTap: () {
              showDetailPlace(f.placeId);
            },
            highlightColor: Colors.lightBlueAccent,
            splashColor: Colors.red,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: list,
              ),
            ),
          ),
        ),
      );
    }).toList();

    return ListView(shrinkWrap: true, children: placesWidget);
  }
}