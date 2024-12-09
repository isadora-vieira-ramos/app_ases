import 'package:app_ases/models/flight_info.dart';
import 'package:app_ases/models/position.dart';
import 'package:app_ases/models/user.dart';
import 'package:app_ases/screens/flight_code.dart';
import 'package:app_ases/services/flight_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:intl/intl.dart';


class ActionBar extends StatefulWidget {
  final bool takePhoto;
  final FlightInfo flightInfo;
  final UserType userType;
  final String flightCode;
  ActionBar({required this.takePhoto, required this.flightInfo, required this.userType, required this.flightCode});

  @override
  State<ActionBar> createState() => _ActionBarState();
}

class _ActionBarState extends State<ActionBar> {
  final geo.GeolocatorPlatform _geolocatorPlatform = geo.GeolocatorPlatform.instance;
  final FlightService flightService = FlightService();
  final ImagePicker _picker = ImagePicker();
  String updateMessage ="";
  Position? position;

  Future<void> _pickImage(BuildContext context) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final String extension = image.name.split('.').last.toLowerCase();
      if (extension == 'jpg' || extension == 'jpeg' || extension == 'png') {
        Fluttertoast.showToast(
          msg: "Imagem alterada",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xFF64ccf3), 
          textColor: Colors.white,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Formato inválido",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xFF64ccf3),
          textColor: Colors.white,
        );
      }
    }
  }

  bool distanceBetweenTwoPoints(double startLatitude, double startLongitude, double endLatitude, double endLongitude){
    var distanceInMeters = _geolocatorPlatform.distanceBetween(startLatitude, startLongitude, endLatitude, endLongitude);
    if(distanceInMeters > 555){ //verifica se a distância é maior que 0,3 milhas
      return true;
    }else{
      return false;
    }
  }

  void sendPosition()async{
    List<String> stretchList = widget.flightInfo.stretchs.map((stretch) => "De ${stretch.origin} até ${stretch.destination}").toList();

    String currentStretch = stretchList.first;
    AlertDialog alert = AlertDialog(
      title: const Text("Qual a sua posição?",
          style: TextStyle(
            fontSize: 17,
          )),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownMenu<String>(
                initialSelection: stretchList.first,
                onSelected: (value) {
                  setState(() {
                    currentStretch = value!;
                  });
                },
                dropdownMenuEntries: stretchList
                    .map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value, labelWidget: Text(value, style: const TextStyle(fontSize: 12),));
                }).toList()),
          ],
        ),
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
          onPressed: () async {
            int stretchIndex = stretchList.indexOf(currentStretch) + 1;
            sendPositionToAPI(stretchIndex);
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

  void sendPositionToAPI(int stretchIndex)async{
    final geolocatorPosition = await _geolocatorPlatform.getCurrentPosition();
    
    if(position != null){
      double startLatitude = double.parse(position!.latitude);
      double startLongitude = double.parse(position!.longitude);
      
      bool isDistanceSignificative = distanceBetweenTwoPoints(
        startLatitude, startLongitude, geolocatorPosition.latitude, geolocatorPosition.longitude);

      if(!isDistanceSignificative){
        Navigator.pop(context);
        showSnackBar("Distância entre o último ponto enviado e o atual é bem curta. Espere um pouco para enviar novamente.");
        return;
      }
    }

    position = Position(
      userType: widget.userType, 
      flightCode: widget.flightCode,
      flightId: widget.flightInfo.id,
      stretch: stretchIndex,
      date: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
      latitude: geolocatorPosition.latitude.toString(),
      longitude: geolocatorPosition.longitude.toString(),
      speed: geolocatorPosition.speed,
      altitude: geolocatorPosition.altitude
    );
    var result = await flightService.sendPosition(position!);
    if(result){
      updateMessage = "Atualizado com sucesso!";
    }else{
      updateMessage = "Não foi possível atualizar. Tente novamente";
    }
    Navigator.pop(context);
    showSnackBar(updateMessage);
  }

  showSnackBar(String message){
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 20
        ),
      ),
    ));
  } 

  Future<void> getCurrentPosition() async {
    final hasPermission = await handlePermission();

    if (!hasPermission) {
      showSnackBar("Não é possível enviar a posição sem permitir que o app verifique sua localização.");
    }else{
      sendPosition();
    }
  }

  Future<bool> handlePermission() async {
    bool serviceEnabled;
    geo.LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == geo.LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == geo.LocationPermission.denied) {
        return false;
      }
    }

    if (permission == geo.LocationPermission.deniedForever) {
      return false;
    }
    return true;
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
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Informação do Piloto'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.network(widget.flightInfo.volunteers[0].photo, height: 100),
                    const SizedBox(height: 8),
                    Text(widget.flightInfo.volunteers[0].name,
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
                onTap: getCurrentPosition,
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
