import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_ases/models/flight_info.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FlightService {
  String chekinEndpoint = '/api_checking/index.php';
  String sendPositionEndpoint = '/api_send_postion/index.php';
  String sendMessageEndpoint = '/api_send_message/index.php';
  String getMessagesEndpoint = '/api_get_messages/index.php';

  Future<FlightInfo> fetchFlightInfo() async {
    final String apiUrl = '${dotenv.env['API_URL'].toString()}$chekinEndpoint';
    Map data = {
      'TOKEN': dotenv.env['TOKEN'].toString(),
      'TIPO': 'PACIENTE',
      'CODIGO': '121212'
    };
    var body = json.encode(data);

    var response = await http.post(Uri.parse(apiUrl), body: body);

    if (response.statusCode == 200) {
      dynamic jsonResponse = json.decode(response.body);
      return ResponseJson.fromJson(jsonResponse).flightInfo;
    } else {
      throw Exception('Failed to load flight info');
    }
  }
}
