import 'package:app_ases/models/flight_info.dart';
import 'package:app_ases/models/user.dart';
import 'package:app_ases/screens/flight_code.dart';
import 'package:app_ases/services/flight_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ActionBar extends StatefulWidget {
  final bool takePhoto;
  Function updatePosition;
  ActionBar({super.key, required this.takePhoto, required this.updatePosition});

  static List<String> positionList = <String>[
    'Em deslocamento até aeroporto',
    'Embarque',
    'Em voo',
    'Em deslocamento até hospital',
    'Chegada'
  ];

  @override
  State<ActionBar> createState() => _ActionBarState();
}

class _ActionBarState extends State<ActionBar> {
  final FlightService flightService = FlightService();
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(BuildContext context) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Verifica a extensão do arquivo
      final String extension = image.name.split('.').last.toLowerCase();
      print('Extensão da imagem: $extension'); // Log para depuração
      if (extension == 'jpg' || extension == 'jpeg' || extension == 'png') {
        Fluttertoast.showToast(
          msg: "Imagem alterada",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xFF64ccf3), // Cor de fundo azul
          textColor: Colors.white, // Cor do texto
        );
      } else {
        Fluttertoast.showToast(
          msg: "Formato inválido",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xFF64ccf3), // Cor de fundo vermelha
          textColor: Colors.white, // Cor do texto
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    void exit() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FlightCode()),
      );
    }

    void showFlightInfoModal() async {
      try {
        FlightInfo? flightInfo =
            await flightService.fetchFlightInfo(UserType.volunteer, '1234');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Informação do Piloto'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.network(flightInfo!.volunteers[0].photo, height: 100),
                    const SizedBox(height: 8),
                    Text(flightInfo!.volunteers[0].name,
                        style: const TextStyle(fontSize: 18)),
                    const Divider(),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Fechar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Erro'),
              content: const Text(
                  'Não foi possível carregar as informações do piloto'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Fechar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }

    void sendPosition() {
      String currentPosition = "";
      AlertDialog alert = AlertDialog(
        title: const Text("Qual a sua posição?",
            style: TextStyle(
              fontSize: 17,
            )),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownMenu<String>(
              initialSelection: ActionBar.positionList.first,
              onSelected: (value) {
                setState(() {
                  currentPosition = value!;
                });
              },
              dropdownMenuEntries: ActionBar.positionList
                  .map<DropdownMenuEntry<String>>((String value) {
                return DropdownMenuEntry<String>(value: value, label: value);
              }).toList()),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
                backgroundColor: Colors.red, foregroundColor: Colors.white),
            child: const Text("Cancelar"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white),
            child: const Text("OK"),
            onPressed: () {
              widget.updatePosition(currentPosition);
              Navigator.pop(context);
            },
          )
        ],
      );
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          });
    }

    return Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.takePhoto) ...[
              GestureDetector(
                  onTap: () => _pickImage(context),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.add_a_photo_outlined),
                      Text("Foto", textAlign: TextAlign.center)
                    ],
                  )),
            ] else ...[
              GestureDetector(
                  onTap: showFlightInfoModal,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.info_outline),
                      Text("Info", textAlign: TextAlign.center)
                    ],
                  )),
            ],
            GestureDetector(
                onTap: sendPosition,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on_outlined),
                    Text("Enviar posição", textAlign: TextAlign.center)
                  ],
                )),
            GestureDetector(
                onTap: exit,
                child: const Column(
                  children: [
                    Icon(Icons.exit_to_app),
                    Text("Sair", textAlign: TextAlign.center)
                  ],
                ))
          ],
        ));
  }
}
