import 'package:app_ases/models/flight_info.dart';
import 'package:app_ases/models/user.dart';
import 'package:app_ases/utils/action_bar.dart';
import 'package:app_ases/utils/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Home extends StatefulWidget {
  FlightInfo flightInfo;
  UserType userType;
  String flightCode;
  Function setStretch;
  int currentStretch;
  Home(
      {super.key,
      required this.flightInfo,
      required this.userType,
      required this.flightCode,
      required this.setStretch,
      required this.currentStretch});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ActionBar(
            takePhoto: true,
            flightInfo: widget.flightInfo,
            userType: widget.userType,
            flightCode: widget.flightCode,
            setStretch: widget.setStretch),
        Expanded(
          child: ChatWidget(
            userType: widget.userType,
            userCode: widget.flightCode,
            flightInfo: widget.flightInfo,
            currentStretch: widget.currentStretch,
          ),
        ),
      ],
    ));
  }
}
