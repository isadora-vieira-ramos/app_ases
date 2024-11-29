import 'package:app_ases/models/flight_info.dart';
import 'package:app_ases/models/user.dart';
import 'package:app_ases/utils/action_bar.dart';
import 'package:app_ases/utils/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Home extends StatelessWidget {
  FlightInfo flightInfo;
  UserType userType;
  String flightCode;
  Home({super.key, required this.flightInfo, required this.userType, required this.flightCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ActionBar(takePhoto: true, flightInfo: flightInfo, userType: userType, flightCode: flightCode),
        Expanded(
          child: ChatWidget(
            apiUrl: dotenv.env['API_URL'].toString(),
            token: dotenv.env['TOKEN'].toString(),
            codigo: "121212",
            acionamentoId: flightInfo.id,
            origemId: 9, 
          ),
        ),
      ],
    ));
  }
}
