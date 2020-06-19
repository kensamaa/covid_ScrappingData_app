

import 'dart:convert';

//import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scan_bluetooth/flutter_scan_bluetooth.dart';
import 'package:http/http.dart' as http;

class BlueToothProvider with ChangeNotifier{
  /*
  FlutterBlue flutterBlue = FlutterBlue.instance;//Obtain an instance
  String _data = 'Nobody found yet!';
  bool isOn;
  FlutterScanBluetooth _bluetooth = FlutterScanBluetooth();


  BlueToothProvider.initialize(){
    searchForDevices();
  }

  Future<void> searchForDevices()async{
    isOn = await flutterBlue.isOn;
    //notifyListeners();
    if(!isOn){
      return;
    }else{
      await _bluetooth.startScan(pairedDevices: false);

      _bluetooth.devices.toList().then((v){
        print("number of devices: ${ v.length}");
      });
      _bluetooth.devices.listen((device) {
        if(device != null){
          _data = "";
        }
        _data += device.name+' (${device.address})\n';
        //notifyListeners();
      });
    }
  }

  Future<http.Response> notifydb(String id,String lar,String lon) async {
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


*/

}
