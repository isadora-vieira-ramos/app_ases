import 'dart:convert';
import 'package:app_ases/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:app_ases/models/flight_info.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FlightService {
  String chekinEndpoint = '/api_checking/index.php';
  String sendPositionEndpoint = '/api_send_postion/index.php';
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
        dynamic jsonResponse = json.decode(response.body);
        var responseJson = ResponseJson.fromJson(jsonResponse);
        return responseJson.flightInfo;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
