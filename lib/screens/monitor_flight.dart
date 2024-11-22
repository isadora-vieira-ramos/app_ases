import 'package:app_ases/models/flight_info.dart';
import 'package:app_ases/utils/action_bar.dart';
import 'package:flutter/material.dart';

class MonitorFlightScreen extends StatefulWidget {
  final FlightInfo flightInfo;

  MonitorFlightScreen({super.key, required this.flightInfo});

  @override
  State<MonitorFlightScreen> createState() => _MonitorFlightScreenState();
}

class _MonitorFlightScreenState extends State<MonitorFlightScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Barra de ação do topo
        ActionBar(takePhoto: false, flightInfo: widget.flightInfo),
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
                  "Informações sobre os trechos.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 140, 146, 151),
                  ),
                ),
                const SizedBox(height: 16),

                // Stepper adaptado
                Expanded(
                  child: Stepper(
                    type: StepperType.vertical,
                    controlsBuilder:
                        (BuildContext context, ControlsDetails details) {
                      return const SizedBox.shrink(); // Remove os botões padrão
                    },
                    steps: widget.flightInfo.stretchs
                        .asMap()
                        .entries
                        .map<Step>((entry) {
                      int index = entry.key;
                      var stretch = entry.value;

                      // Selecionar ícone conforme etapa
                      IconData stepIcon;
                      if (index == 0 || index == 3) {
                        stepIcon =
                            Icons.directions_car; // Carro para etapas 1 e 4
                      } else {
                        stepIcon = Icons.flight; // Avião para etapas 2 e 3
                      }

                      return Step(
                        isActive: true,
                        state: StepState.indexed,
                        title: Row(
                          children: [
                            Icon(
                              stepIcon,
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
                        subtitle: const Text("Status: em andamento"),
                        content: Text(
                          "Informações detalhadas sobre o trecho ${stretch.stretchName}.",
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
