import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_ases/models/flight_info.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FlightService {
  Future<FlightInfo> fetchFlightInfo() async {
    final String apiUrl = dotenv.env["API_URL"].toString();
    final String apiKey = dotenv.env["API_KEY"].toString();
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'apikey': apiKey,
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((data) => FlightInfo.fromJson(data))
          .toList()
          .first;
    } else {
      throw Exception('Failed to load flight info');
    }
  }
}
