import 'package:flutter/material.dart';
import '../constant.dart';

class Countercity extends StatelessWidget {
  final String number;
  final Color color;
  final String title;

  const Countercity({
    Key key,
    this.number,
    this.color,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(6),
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(.26),
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(
                color: color,
                width: 1,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          number,
          style: TextStyle(
            fontSize: 20,
            color: color,
          ),
        ),
        Text(title, style: kSubTextStyle),
      ],
    );
  }
}
