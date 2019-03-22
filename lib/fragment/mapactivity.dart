import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:stowaway_application/activity/place_order_form.dart';


class MapActivity extends StatefulWidget {
  @override
  _MapActivityState createState() => _MapActivityState();
}

class _MapActivityState extends State<MapActivity> {
  GoogleMapController mapController;
  MapType _currentMapType = MapType.normal;

  final LatLng _center = const LatLng(22.719568, 75.857727);

  void _onMapCreated(GoogleMapController controller) {
    try{
    mapController = controller;
    mapController.addMarker(
        MarkerOptions(
          position: LatLng(
            mapController.cameraPosition.target.latitude,
            mapController.cameraPosition.target.longitude,
          ),
          infoWindowText: InfoWindowText('Indore', 'Sudama Nagar'),
          icon: BitmapDescriptor.defaultMarker,
        ),
    );
  }catch(e){
      e.toString();
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {

    });
  }

  void _onMapTypeButtonPressed() {
    if (_currentMapType == MapType.normal) {
      mapController.updateMapOptions(
        GoogleMapOptions(mapType: MapType.satellite),
      );
      _currentMapType = MapType.satellite;
    } else {
      mapController.updateMapOptions(
        GoogleMapOptions(mapType: MapType.normal),
      );
      _currentMapType = MapType.normal;
    }
  }

  void _onAddMarkerButtonPressed() {
    mapController.addMarker(
      MarkerOptions(
        position: LatLng(
          mapController.cameraPosition.target.latitude,
          mapController.cameraPosition.target.longitude,
        ),
        infoWindowText: InfoWindowText('Random Place', '5 Star Rating'),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Stack(
          children: <Widget>[
          GoogleMap(
          onMapCreated: _onMapCreated,
            options: GoogleMapOptions(
          trackCameraPosition: true,

            cameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
          ),
          ),
          ),
          Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Expanded(
              child: new Align(
                alignment: FractionalOffset.bottomCenter,
                child:  new Container(
                    child: new SizedBox(
                      width: double.infinity,

                      child: new RaisedButton(
                        onPressed: () {
                          Navigator.push(context,
                              new MaterialPageRoute(builder: (BuildContext context) => PlaceBookForm()));
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
}