import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
class mapPage extends StatefulWidget {
  @override
  _mapPageState createState() => _mapPageState();
}

class _mapPageState extends State<mapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 200,
            width: double.infinity,
            decoration:
            BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.amberAccent,
                    Colors.amber
                  ]
              ),
              color: Colors.black,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: Color(0xFFE5E5E5),
              ),
            ),
          ),

          SizedBox(
            height: 20,
          ),
            Container(
              height: 550,

              child: FlutterMap(
                options: new MapOptions(
                  center: new LatLng(31.7858387, -9.3939546),
                  //zoom: 23.0,
                  minZoom: 10.0
                ),
                layers: [
                  new TileLayerOptions(
                      urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c']
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
