import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';

class mapPage extends StatefulWidget {
  @override
  _mapPageState createState() => _mapPageState();
}

class _mapPageState extends State<mapPage> {

  MapController controller=new MapController();
  Position position;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  List<Marker> markers;
  //String _currentAddress;

  void initState(){
    super.initState();
    _getCurrentLocation();
  }
  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
      print("location");
      print(_currentPosition.latitude.runtimeType);
      print(_currentPosition.longitude.runtimeType);


    }).catchError((e) {
      print(e);
    });
  }
  getPosition()async{
     position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 100,
            width: double.infinity,
            decoration:
            BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.deepPurple,
                    Colors.deepPurpleAccent
                  ]
              ),
              color: Colors.black,
              //borderRadius: BorderRadius.circular(25),
              //border: Border.all(
              //  color: Color(0xFFE5E5E5),
              //),
            ),
            //child: Text((_currentPosition.latitude+_currentPosition.longitude).toString()),
          ),


            Container(
              height: 670,

              child: FlutterMap(
                mapController: controller,
                options: new MapOptions(
                  center: new LatLng(_currentPosition.latitude,_currentPosition.longitude),
                  zoom: 13,
                  //minZoom: 10.0
                ),
                layers: [
                  new TileLayerOptions(
                      urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c']
                  ),
                  new MarkerLayerOptions(
                    markers: [
                      Marker(//this is user marker
                          height: 30,
                          width: 30,
                          point: new LatLng(_currentPosition.latitude, _currentPosition.longitude),
                          builder: (ctx) =>Icon(Icons.pin_drop,color: Colors.red)

                      ),
                      Marker(//this is emsi
                          height: 30,
                          width: 30,
                          point: new LatLng(33.541505, -7.673544),
                          builder: (ctx) =>Icon(Icons.pin_drop,color: Colors.green)
                      ),
                      Marker(//this is hospital chaikh zaid
                          height: 30,
                          width: 30,

                          point: new LatLng(33.5523758, -7.6699494),
                          builder: (ctx) =>Container(
                            child: Text("chaikh khalifa"),
                          ),
                      ),

                    ],
                  ),
                  new CircleLayerOptions(
                    circles: [
                      CircleMarker(
                        point: new LatLng(_currentPosition.latitude, _currentPosition.longitude),
                        radius: 10,
                        color: Colors.green,
                        borderColor: Colors.red,
                        borderStrokeWidth: 2,
                        useRadiusInMeter: false,

                      )
                    ]
                  )

                ],
              ),
            ),
        ],
      ),
    );

  }


}
