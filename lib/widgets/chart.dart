

import 'dart:convert';

import 'package:charts_flutter/flutter.dart'as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' ;

import 'package:http/http.dart' as http;
import '../CoronaData.dart';

class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}

class chart extends StatefulWidget {

  @override
  _chartState createState() => _chartState();
}

class _chartState extends State<chart> {
  final String api="http://192.168.1.8:5000/last";
  coronaCity coronacity;
  List<charts.Series<Task, String>> _seriesPieData;
  _generateData() {
    var piedata = [
      new Task(coronacity.casablanca.name , coronacity.casablanca.value , Color(0xff3366cc)),
      new Task(coronacity.marakech.name , coronacity.marakech.value, Color(0xff990099)),
      new Task(coronacity.Rabat.name , coronacity.Rabat.value, Color(0xff109618)),
      new Task(coronacity.tanger.name , coronacity.tanger.value, Color(0xfffdbe19)),
      new Task(coronacity.Fesmeknes.name , coronacity.Fesmeknes.value,Color(0xffff9900)),
      new Task(coronacity.oriental.name , coronacity.oriental.value, Color(0xffdc3912)),
      new Task(coronacity.beniMellal.name , coronacity.beniMellal.value, Color(0xFF424242)),
      new Task(coronacity.DaraaTafilalet.name , coronacity.DaraaTafilalet.value, Color(0xFFA1887B)),
      new Task(coronacity.DakhlaOuedEdDahab.name , coronacity.DakhlaOuedEdDahab.value, Color(0xFFE040FB)),
      new Task(coronacity.SoussMassa.name , coronacity.SoussMassa.value, Color(0xFFC5E1A5)),
      new Task(coronacity.LaayouneSakiaElHamra.name , coronacity.LaayouneSakiaElHamra.value, Color(0xFF4DB6AC)),
      new Task(coronacity.Guelmim.name , coronacity.Guelmim.value, Color(0xFFFCE4EC)),
    ];

    _seriesPieData.add(
      charts.Series(
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskvalue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorval),
        id: 'Air Pollution',
        data: piedata,
        labelAccessorFn: (Task row, _) => '${row.taskvalue}',
      ),
    );

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getJsonData();
    _seriesPieData = List<charts.Series<Task, String>>();

    _generateData();
  }
  Future<String> getJsonData()async{
    var response=await http.get(
        Uri.encodeFull(api),
        headers:{"Accept":"application/json"});
    //print(response.body);

    setState(() {
      var convertdatajson= jsonDecode(response.body);

      //clean data
      double casablanca=stringtodouble(convertdatajson['casablanca']);
      double marakech=stringtodouble(convertdatajson['marakech']);
      double Rabat=stringtodouble(convertdatajson['Rabat']);
      double tanger=stringtodouble(convertdatajson['tanger']);
      double Fesmeknes=stringtodouble(convertdatajson['Fesmeknes']);
      double oriental=stringtodouble(convertdatajson['oriental']);
      double beniMellal=stringtodouble(convertdatajson['beniMellal']);
      double DaraaTafilalet=stringtodouble(convertdatajson['DaraaTafilalet']);
      double DakhlaOuedEdDahab=stringtodouble(convertdatajson['DakhlaOuedEdDahab']);
      double SoussMassa=stringtodouble(convertdatajson['SoussMassa']);
      double LaayouneSakiaElHamra=stringtodouble(convertdatajson['LaayouneSakiaElHamra']);
      double Guelmim=stringtodouble(convertdatajson['Guelmim']);

      coronacity=new coronaCity(
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
      coronacity.toString();

    });
  }



  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: charts.PieChart(
              _seriesPieData,
              animate: true,
              animationDuration: Duration(seconds: 2),
              behaviors: [
                new charts.DatumLegend(
                  outsideJustification: charts.OutsideJustification.endDrawArea,
                  horizontalFirst: false,
                  desiredMaxRows: 2,
                  cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
                  entryTextStyle: charts.TextStyleSpec(
                    color: charts.MaterialPalette.purple.shadeDefault,
                    fontFamily: 'Georgia',
                    fontSize: 15,


                  ),
                )
              ],
              defaultRenderer: new charts.ArcRendererConfig(
                  arcWidth: 100,
                  arcRendererDecorators: [
                    new charts.ArcLabelDecorator(
                        labelPosition: charts.ArcLabelPosition.inside)
                  ])),
        ),
      ),
    );


  }}
