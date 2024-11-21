import 'package:app_ases/models/flight_info.dart';
import 'package:app_ases/utils/action_bar.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  FlightInfo flightInfo;
  Home({super.key, required this.flightInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [ActionBar(takePhoto: true, updatePosition: () {}, flightInfo: flightInfo)],
    ));
  }
}
