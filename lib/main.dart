import 'package:covidapp/constant.dart';
import 'package:covidapp/widgets/chart.dart';

import 'package:covidapp/widgets/counter.dart';
import 'package:covidapp/widgets/counterCity.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import 'CoronaData.dart';
import 'mapPage.dart';
const url="https://www.worldometers.info/coronavirus/country/morocco/";

void main() => runApp(MyApp());




class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'covid Morocco',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        fontFamily: "Poppins",
        textTheme: TextTheme(
          body1: TextStyle(color: kBodyTextColor),
        )
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //*******************+api
  final String api="http://192.168.1.42:5000/last";
  String awway,ddate;
  CoronaData corona;
  String casablanca,marakech,Rabat,tanger,Fesmeknes,oriental,beniMellal,DaraaTafilalet,DakhlaOuedEdDahab,SoussMassa,LaayouneSakiaElHamra,Guelmim;
  //coronaCity coronacity;

  @override
  void initState()  {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData()async{
    var response=null;
    try {//if the backend is workign or not
       response=await http.get(
          Uri.encodeFull(api),
          headers:{"Accept":"application/json"});
    }
    catch(e){
      print("back end not working");
    }

    //print(response.body);

    setState(() {
      var convertdatajson= jsonDecode(response.body);
      String awayy=convertdatajson['casExclus'];
      String cases=convertdatajson['cases'];
      String died=convertdatajson['died'];
      String cure=convertdatajson['cured'];
      String Date=convertdatajson['date'];
      ddate=Date.replaceAll('T', ' ').replaceAll('Z', ' ').replaceAll('-', '/');

      awway=awayy;
      //CoronaData(this.cases, this.dead, this.cured, this.away);
      corona=new CoronaData(cases,died,cure,awayy);
      //clean data
       casablanca=(convertdatajson['casablanca']);
       marakech=(convertdatajson['marakech']);
       Rabat=(convertdatajson['Rabat']);
       tanger=(convertdatajson['tanger']);
       Fesmeknes=(convertdatajson['Fesmeknes']);
       oriental=(convertdatajson['oriental']);
       beniMellal=(convertdatajson['beniMellal']);
       DaraaTafilalet=(convertdatajson['DaraaTafilalet']);
       DakhlaOuedEdDahab=(convertdatajson['DakhlaOuedEdDahab']);
       SoussMassa=(convertdatajson['SoussMassa']);
       LaayouneSakiaElHamra=(convertdatajson['LaayouneSakiaElHamra']);
       Guelmim=(convertdatajson['Guelmim']);

      /*coronacity=new coronaCity(
          new ville('casablanca', casablanca),
        new ville('marakech', marakech),
        new ville('Rabat', Rabat),
        new ville('tanger', tanger),
        new ville('Fesmeknes', Fesmeknes),
        new ville('oriental', oriental),
        new ville('beniMellal',  beniMellal),
        new ville('DaraaTafilalet', DaraaTafilalet),
        new ville('DakhlaOuedEdDahab', DakhlaOuedEdDahab),
        new ville('SoussMassa', SoussMassa),
        new ville('LaayouneSakiaElHamra', LaayouneSakiaElHamra),
        new ville('Guelmim', Guelmim)
      );
      coronacity.toString();*/
      
    });
  }

//******************************chart thing



  //*************************website connect

  // ignore: non_constant_identifier_names
  Future Lunchwebsite(String url)async{
    if (await canLaunch(url)) {
           await launch(url, forceSafariVC: false, forceWebView: false);
         }
    else {
           print("Can't Launch $url");
        }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: <Widget>[
         Column(
          children: <Widget>[
              Container(
                height: 200,
                width: double.infinity,
                decoration:
                BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.teal,
                      Colors.greenAccent
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
              height: 20,//leaves the space beetwen the green header and case update
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'case update\n\n',
                              style: kTitleTextstyle,//from the constant file
                                ),
                            TextSpan(
                              text: "last update "+ddate,
                                style: TextStyle(
                                  color: kTextLightColor,
                                ) ,
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      FlatButton(
                        onPressed: (){
                          _launchURL(url);
                        },
                        child: Text(
                            "see detailes",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),//case update
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 30,
                          color: kShadowColor,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        //*****************these are the infected death cured cards
                        Counter(
                          color: kInfectedColor,
                          number: corona.cases,
                          title: "Infected",
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Counter(
                          color: kDeathColor,
                          number: corona.dead,
                          title: "Deaths",
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Counter(
                          color: kRecovercolor,
                          number: corona.cured,
                          title: "Recovered",
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Counter(
                          color: kAwaycolor,
                          number: awway,
                          title: "away",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child:  Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Countercity(color: kCountrycolor, number: casablanca, title: "casablanca",),
                            Countercity(color: kCountrycolor, number: marakech, title: "marakech",),
                          Countercity(color: kCountrycolor, number: Rabat, title: "Rabat",),
                          Countercity(color: kCountrycolor, number: tanger, title: "tanger",),
                        ],
                          ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                          children: <Widget>[
                            Countercity(color: kCountrycolor, number: Fesmeknes, title: "Fesmeknes",),
                            Countercity(color: kCountrycolor, number: oriental, title: "oriental",),
                            Countercity(color: kCountrycolor, number: beniMellal, title: "beniMellal",),
                            Countercity(color: kCountrycolor, number: DaraaTafilalet, title: "Tafilalet",),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Countercity(color: kCountrycolor, number: DakhlaOuedEdDahab, title: "OuedEdDahab",),
                            Countercity(color: kCountrycolor, number: SoussMassa, title: "SoussMassa",),
                            Countercity(color: kCountrycolor, number: LaayouneSakiaElHamra, title: "Laayoune",),
                            Countercity(color: kCountrycolor, number: Guelmim, title: "Guelmim",),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),//body basically
          ],
        ),
          //the second page*******************************
          mapPage(),



        ],


      ),  //all the screen
    );
  }
}
_launchURL(String url) async {

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}