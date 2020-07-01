import 'dart:async';
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:covidapp/widgets/user.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
//import 'package:flutter_blue/flutter_blue.dart';



class mapPage extends StatefulWidget {
  @override
  _mapPageState createState() => _mapPageState();
}

class _mapPageState extends State<mapPage> {

  MapController controller=new MapController();
  Position position;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  //List<Marker> markers;
  String deviceId,id,latitude,longitude;
  DeviceInfoPlugin deviceInfo =DeviceInfoPlugin(); // instantiate device info plugin
  AndroidDeviceInfo androidDeviceInfo;
  //FlutterBlue flutterBlue = FlutterBlue.instance;//Obtain an instance

  // Start scanning
  /*flutterBlue.startScan(timeout: Duration(seconds: 4));
  // Listen to scan results

  var subscription = flutterBlue.scanResults.listen((results) {
    // do something with scan results
    for (ScanResult r in results) {
        print('${r.device.name} found! rssi: ${r.rssi}');
    }
});
*/
  Future<void> initState()  {
    super.initState();
    _getCurrentLocation();//get the location
    //setId();
    getDeviceinfo();//get the id
    //createAlbum(id,latitude,longitude);
    //final User user = await createUser(id, latitude,longitude);
    //user u=new user(id,longitude,latitude);
    sendDataUser("id","latitude","longitude");

  }

  Future<http.Response> sendDataUser(String id,String lar,String lon) async {
    var now = new DateTime.now();
    final http.Response response = await http.post(
      'http://192.168.1.42:5000/user/add',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "PhoneId":id,
        "latitude":lar,
        "longitude": lon,
        "date": now.toString()
      }),
    );
    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print("done");
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        latitude=_currentPosition.latitude.toString();
        longitude=_currentPosition.longitude.toString();
      });

      print("location");
      latitude=_currentPosition.latitude.toString();
      longitude=_currentPosition.longitude.toString();
      sendDataUser("id","latitude","longitude");

    }).catchError((e) {
      print(e);
    });
  }

  getPosition()async{
     position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

  }
  /*
  setId() async {
    deviceId = await _getId();
    print(deviceId);
  }
  Future<String> _getId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }*/
  void getDeviceinfo() async {
    androidDeviceInfo = await deviceInfo
        .androidInfo; // instantiate Android Device Infoformation
    setState(() {

      id = androidDeviceInfo.id;

    });
    id = androidDeviceInfo.id;
    print("id");
    print(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            decoration:
            BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.deepPurple[200],
                    Colors.deepPurple[300]
                  ]
              ),
              color: Colors.black,
              //borderRadius: BorderRadius.circular(25),
              //border: Border.all(
              //  color: Color(0xFFE5E5E5),
              //),
            ),
            child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topCenter,
          
                      ),
                      SizedBox(height: 40),
                      Expanded(
                        child: Stack(
                          children: <Widget>[
                            Center(
                              child: SvgPicture.asset(
                                'images/geo.svg',
                                fit: BoxFit.fitHeight,
                                alignment: Alignment.center,
                                width: 200,
                                
                           
                            
                            )
                             ,)
                           
                          ],
                      ),),
                ],),
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
                          builder: (ctx) =>Container(
                                  key: Key('blue'),
                                  child: Icon(Icons.location_on,color: Colors.red,size: 30.0,),
                                  ),
                      ),
                      Marker(//this is emsi
                          height: 30,
                          width: 30,
                          point: new LatLng(33.541505, -7.673544),
                          builder: (ctx) => Image.asset('images/emsi.jpg')
                      ),
                      

                    ],
                  ),
                  /*new CircleLayerOptions(
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
                  )*/

                ],
              ),
            ),
        ],
      ),
    );

  }


}
