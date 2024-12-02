import 'dart:convert';
import 'package:app_ases/models/position.dart';
import 'package:app_ases/models/requestResponse.dart';
import 'package:app_ases/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:app_ases/models/flight_info.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FlightService {
  String chekinEndpoint = '/api_checking/index.php';
  String sendPositionEndpoint = '/api_send_position/index.php';
  String sendMessageEndpoint = '/api_send_message/index.php';
  String getMessagesEndpoint = '/api_get_messages/index.php';

  Future<FlightInfo?> fetchFlightInfo(
      UserType userType, String flightCode) async {
    final String apiUrl = '${dotenv.env['API_URL'].toString()}$chekinEndpoint';
    late String type;
    type = User.getUserTypeDescription(userType).toUpperCase();

    Map data = {
      'TOKEN': dotenv.env['TOKEN'].toString(),
      'TIPO': type,
      'CODIGO': flightCode
    };
    var body = json.encode(data);

    var response = await http.post(Uri.parse(apiUrl), body: body);

    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        if(jsonResponse.containsKey("status")){
          return null;
        }else{
          var responseJson = FlightResponseJson.fromJson(jsonResponse);
          return responseJson.flightInfo;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> sendPosition(Position position) async{
    final String apiUrl = '${dotenv.env['API_URL'].toString()}$sendPositionEndpoint';
    late String type;
    type = User.getUserTypeDescription(position.userType).toUpperCase();

    Map data = {
      'TOKEN': dotenv.env['TOKEN'].toString(),
      'TIPO': type,
      'CODIGO': position.flightCode,
      'ACIONAMENTO_ID': position.flightId,
      'TRECHO' : position.stretch,
      'DATA_COLETA': position.date,
      'LATITUDE': position.latitude,
      'LONGITUDE': position.longitude,
      'VELOCIDADE': position.speed,
      'ALTITUDE': position.altitude
    };

    try{
      var body = json.encode(data);
      var response = await http.post(Uri.parse(apiUrl), body: body);

      dynamic jsonResponse = json.decode(response.body);
      var responseJson = RequestResponse.fromJson(jsonResponse);

      if(responseJson.status == 200){
        return true;
      }else{
        return false;
      }
    }catch(e){
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> fetchMessages(UserType userType, FlightInfo flightInfo, String userCode, int origemId) async {
    var type = User.getUserTypeDescription(userType).toUpperCase();
    
    final response = await http.post(
      Uri.parse('${dotenv.env['API_URL'].toString()}$getMessagesEndpoint'), // URL correta
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "TOKEN": dotenv.env['TOKEN'].toString(),
        "TIPO": type,
        "CODIGO": userCode,
        "ACIONAMENTO_ID": flightInfo.bookingCode,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
        // Filtrando mensagens pelo ORIGEM_ID
        return List<Map<String, dynamic>>.from(data['MENSAGEMS'])
            .where((message) => message['ORIGEM_ID'] == origemId)
            .toList();
    } else {
      return List<Map<String, dynamic>>.empty();
    }
  }
}
