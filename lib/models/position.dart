import 'package:app_ases/models/user.dart';

class Position {
  late UserType userType;
  late String flightCode;
  late int flightId;
  late int stretch;
  late String date;
  late String latitude;
  late String longitude;
  late double speed;
  late double altitude;

  Position({
    required this.userType, 
    required this.flightCode, 
    required this.flightId, 
    required this.stretch, 
    required this.date,
    required this.latitude, 
    required this.longitude, 
    required this.speed, 
    required this.altitude
  });
}