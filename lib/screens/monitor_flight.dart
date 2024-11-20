import 'package:app_ases/models/flight_info.dart';
import 'package:app_ases/services/flight_service.dart';
import 'package:app_ases/utils/action_bar.dart';
import 'package:flutter/material.dart';

class MonitorFlightScreen extends StatefulWidget {
  const MonitorFlightScreen({super.key});

  @override
  State<MonitorFlightScreen> createState() => _MonitorFlightScreenState();
}

class _MonitorFlightScreenState extends State<MonitorFlightScreen> {
  final FlightService flightService = FlightService();
  String currentPosition = "";

  @override
  Widget build(BuildContext context) {
    void changePositionValue(String value) {
      setState(() {
        currentPosition = value;
      });
    }

    int getIndexInList(String value) {
      if (value.isEmpty) {
        return 0;
      } else {
        return ActionBar.positionList.indexOf(value);
      }
    }

    return Column(
      children: [
        ActionBar(takePhoto: false, updatePosition: changePositionValue),
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
                const Text(
                  "Ponto de Encontro:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Hospital Santa Casa - POA/RS\n24 de outubro, às 18h",
                  style: TextStyle(fontSize: 16),
                ),
                Expanded(
                    child: Stepper(
                        currentStep: getIndexInList(currentPosition),
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
                        steps: ActionBar.positionList.map<Step>((String value) {
                          return Step(
                              title: Text(value),
                              content: Container(child: null),
                              stepStyle: StepStyle(
                                color: getIndexInList(value) <=
                                        getIndexInList(currentPosition)
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey,
                              ));
                        }).toList())),
                const Text(
                  "Ponto de Chegada:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Hospital Santa Isabel - SAO/SP\n24 de outubro, às 21h",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
