// flight_info.dart
class FlightInfo {
  final String id;
  final String pilotPhoto;
  final String pilotName;
  final String origin;
  final String destination;
  String? currentPosition;

  FlightInfo(
      {required this.id,
      required this.pilotPhoto,
      required this.pilotName,
      required this.origin,
      required this.destination,
      this.currentPosition});

  factory FlightInfo.fromJson(Map<String, dynamic> json) {
    return FlightInfo(
        id: json['id'],
        pilotPhoto: json['foto_piloto'],
        pilotName: json['nome_piloto'],
        origin: "Porto Alegre",
        destination: "São Paulo",
        currentPosition: "Em voo");
  }
}
