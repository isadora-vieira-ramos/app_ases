import 'package:app_ases/models/flight_info.dart';
import 'package:app_ases/models/user.dart';
import 'package:app_ases/utils/action_bar.dart';
import 'package:flutter/material.dart';

class MonitorFlightScreen extends StatefulWidget {
  final FlightInfo flightInfo;
  final UserType userType;
  final String flightCode;
  Function setStretch;
  int currentStretch;
  MonitorFlightScreen({super.key, required this.flightInfo, required this.userType, required this.flightCode, required this.setStretch, required this.currentStretch});

  @override
  State<MonitorFlightScreen> createState() => _MonitorFlightScreenState();
}

class _MonitorFlightScreenState extends State<MonitorFlightScreen> {
  int currentIndexStep = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Barra de ação do topo
        ActionBar(
          takePhoto: false, 
          flightInfo: widget.flightInfo, 
          userType: widget.userType, 
          flightCode: widget.flightCode,
          setStretch: widget.setStretch),
        const SizedBox(height: 16),

        // Mensagem de conexão à internet
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
              ],
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Você está conectado a internet!",
                style: TextStyle(fontSize: 16, color: Colors.green),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Conteúdo com Stepper
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
                // Título do conteúdo
                const Text(
                  "Deslocamento do passageiro",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Clique no trecho para visualizar suas informações.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 140, 146, 151),
                  ),
                ),
                // Stepper adaptado
                Expanded(
                  child: Stepper(
                    type: StepperType.vertical,
                    currentStep: widget.currentStretch,
                    controlsBuilder:
                        (BuildContext context, ControlsDetails details) {
                      return const SizedBox.shrink(); // Remove os botões padrão
                    },
                    onStepTapped: (value) {
                      widget.setStretch(value);
                    },
                    steps: widget.flightInfo.stretchs
                        .asMap()
                        .entries
                        .map<Step>((entry) {
                      var stretch = entry.value;

                      return Step(
                        isActive: true,
                        state: StepState.indexed,
                        title: Row(
                          children: [
                            Icon(
                              stretch.type.toLowerCase().contains("carro")? Icons.directions_car: Icons.flight,
                              color: const Color.fromARGB(255, 189, 200, 209),
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              stretch.stretchName,
                              style: const TextStyle(),
                            ),
                          ],
                        ),
                        subtitle: Text("Distância percorrida no trecho: ${stretch.distance} KM"),
                        content: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Origem: ${stretch.origin}"),
                              Text("Destino: ${stretch.destination}"),
                              Text("Duração do trecho: ${stretch.duration}"),
                              if(stretch.type.toLowerCase() != "carro")...{
                                Text("Companhia aérea: ${stretch.flightCompany}"),
                                Text("Voo: ${stretch.flight}")
                              }
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
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
