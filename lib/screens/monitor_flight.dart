import 'package:app_ases/models/flight_info.dart';
import 'package:app_ases/services/flight_service.dart';
import 'package:app_ases/utils/action_bar.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MonitorFlightScreen extends StatefulWidget {
  FlightInfo flightInfo;
  MonitorFlightScreen({super.key, required this.flightInfo});

  @override
  State<MonitorFlightScreen> createState() => _MonitorFlightScreenState();
}

class _MonitorFlightScreenState extends State<MonitorFlightScreen> {
  String currentPosition = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ActionBar(takePhoto: false, flightInfo: widget.flightInfo),
        const SizedBox(height: 16),
        Center(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ]),
            child: const Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(
                "Você está conectado a internet!",
                style: TextStyle(fontSize: 16, color: Colors.green),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stepper(
                    controlsBuilder:
                        (BuildContext context, ControlsDetails details) {
                      return Row(
                        children: <Widget>[
                          Container(
                            child: null,
                          ),
                          Container(
                            child: null,
                          ),
                        ],
                      );
                    },
                    steps: widget.flightInfo.stretchs
                        .map<Step>((stretch) => Step(
                            stepStyle: StepStyle(
                                color: Theme.of(context).primaryColor,
                                connectorColor: Theme.of(context).primaryColor),
                            title: Text(stretch.stretchName),
                            content: const Text(''),
                            subtitle: const Column(
                              children: [Text("Mudar aqui")],
                            )))
                        .toList())
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
