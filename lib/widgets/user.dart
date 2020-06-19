// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.phoneId,
    this.latitude,
    this.longitude,
    this.date,
  });

  String phoneId;
  String latitude;
  String longitude;
  DateTime date;

  factory User.fromJson(Map<String, dynamic> json) => User(
    phoneId: json["PhoneId"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "PhoneId": phoneId,
    "latitude": latitude,
    "longitude": longitude,
    "date": date.toIso8601String(),
  };
}


/*import 'dart:convert';
import 'package:http/http.dart' as http;

class user{
   String id;
   String longitude;
   String largitude;


   user(this.id, this.longitude, this.largitude);

   Future<http.Response> postUser(url){
     var now = new DateTime.now();
     return http.post(
       url,
       headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
       },
       body: jsonEncode(<String, String>{
         "PhoneId":this.id,
         "latitude":this.largitude,
         "longitude": this.longitude,
         "date": now.toString()
       }),
     );
   }

}*/