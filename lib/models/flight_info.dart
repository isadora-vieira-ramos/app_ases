// flight_info.dart
class FlightInfo {
  late int id;
  late String bookingCode; 
  late String status;
  late String departureDate;
  late String returnDate;
  late String origin;
  late String destination;
  late PatientOrChaperone patient;
  late Hospital hospital;
  late Accomodation accomodation;
  late List<PatientOrChaperone> chaperones;
  late Airplane airplane;
  late List<Stretch> stretchs;
  late List<Volunteer> volunteers;

  FlightInfo({
    required this.id, 
    required this.bookingCode,
    required status, 
    required this.departureDate, 
    required this.returnDate, 
    required this.origin,
    required this.destination, 
    required this.patient,
    required this.hospital,
    required this.accomodation,
    required this.chaperones,
    required this.airplane,
    required this.stretchs,
    required this.volunteers
  });

 
  factory FlightInfo.fromJson(Map<String, dynamic> json) {
    return FlightInfo(
      id: json["id"], 
      bookingCode: json["acionamento"], 
      status: json["status"],
      departureDate: json["data_ida"], 
      returnDate: json["data_retorno"], 
      origin: json["cidade_origem"], 
      destination: json["cidade_destino"],
      patient: json["paciente"],
      hospital: json["hospital"],
      accomodation: json["hospedagem"],
      chaperones: json["acompanhantes"],
      airplane: json["aeronave"],
      stretchs: json["trechos"],
      volunteers: json["voluntarios"]
    );
  } 
}

class PatientOrChaperone{
  late int id;
  late String name;
  late String age;
  late String email;
  late String telephone;
  late String height;
  late String weight;
  late String photo;
  late String zipCode;
  late String address;
  late String number;
  late String additionalAddressDetails;
  late String district;
  late String city;
  late String state;
  late String latitude;
  late String longitude;

  PatientOrChaperone({
    required this.id,
    required this.name,
    required this.age,
    required this.email,
    required this.telephone,
    required this.height,
    required this.weight,
    required this.photo,
    required this.zipCode,
    required this.address,
    required this.number,
    required this.additionalAddressDetails,
    required this.district,
    required this.city,
    required this.state,
    required this.latitude,
    required this.longitude
  });

  factory PatientOrChaperone.fromJson(Map<String, dynamic> json) {
    return PatientOrChaperone(
      id: json["id"], 
      name: json["nome"], 
      age: json["idade"],
      email: json["documento"], 
      telephone: json["telefone"], 
      height: json["altura"], 
      weight: json["peso"],
      photo: json["foto"],
      zipCode: json["cep"],
      address: json["endereco"],
      number: json["numero"],
      additionalAddressDetails: json["complemento"],
      district: json["bairro"],
      city: json["cidade"],
      state: json["estado"],
      latitude: json["latitude"],
      longitude: json["longitude"]
    );
  }
}

class Hospital{
  late String id;
  late String name;
  late String healthOfficial; 
  late String photo;
  late String zipCode;
  late String address;
  late String number;
  late String additionalAddressDetails;
  late String district;
  late String city;
  late String state;
  late String latitude;
  late String longitude;

  Hospital({
    required this.id,
    required this.name,
    required this.healthOfficial,
    required this.photo,
    required this.zipCode,
    required this.address,
    required this.number,
    required this.additionalAddressDetails,
    required this.district,
    required this.city,
    required this.state,
    required this.latitude,
    required this.longitude
  });

  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
      id: json["id"], 
      name: json["nome"], 
      healthOfficial: json["contato"],
      photo: json["foto"],
      zipCode: json["cep"],
      address: json["endereco"],
      number: json["numero"],
      additionalAddressDetails: json["complemento"],
      district: json["bairro"],
      city: json["cidade"],
      state: json["estado"],
      latitude: json["latitude"],
      longitude: json["longitude"]
    );
  }
}

class Accomodation{
  late String id;
  late String name;
  late String contactPerson;
  late String photo;
  late String zipCode;
  late String address;
  late String number;
  late String additionalAddressDetails;
  late String district;
  late String city;
  late String state;
  late String latitude;
  late String longitude; 

  Accomodation({
    required this.id,
    required this.name,
    required this.contactPerson,
    required this.photo,
    required this.zipCode,
    required this.address,
    required this.number,
    required this.additionalAddressDetails,
    required this.district,
    required this.city,
    required this.state,
    required this.latitude,
    required this.longitude
  });

  factory Accomodation.fromJson(Map<String, dynamic> json) {
    return Accomodation(
      id: json["id"], 
      name: json["nome"], 
      contactPerson: json["contato"],
      photo: json["foto"],
      zipCode: json["cep"],
      address: json["endereco"],
      number: json["numero"],
      additionalAddressDetails: json["complemento"],
      district: json["bairro"],
      city: json["cidade"],
      state: json["estado"],
      latitude: json["latitude"],
      longitude: json["longitude"]
    );
  }
}

class Airplane{
  late String prefix;
  late String manufacturer;
  late String type;
  late String model;
  late String name;
  late String engine;
  late int speed;
  late String color;
  late String photo;

  Airplane({
    required this.prefix,
    required this.manufacturer,
    required this.type,
    required this.model,
    required this.name,
    required this.engine,
    required this.speed,
    required this.color,
    required this.photo
  });

  factory Airplane.fromJson(Map<String, dynamic> json) {
    return Airplane(
      prefix: json["prefixo"], 
      manufacturer: json["fabricante"],
      type: json["tipo"],
      model: json["modelo"],
      name: json["nome"], 
      engine: json["motor"],
      speed: json["velocidade"],
      color: json["cor"],
      photo: json["foto"],
    );
  }
}

class Stretch{
  late int id;
  late String stretchName;
  late String type;
  late String origin;
  late String destination;
  late String flightCompany;
  late String flight;
  late int distance;

  Stretch({
    required this.id,
    required this.stretchName,
    required this.type,
    required this.origin,
    required this.destination,
    required this.flightCompany,
    required this.flight,
    required this.distance
  });

  factory Stretch.fromJson(Map<String, dynamic> json) {
    return Stretch(
      id: json["trecho"], 
      stretchName: json["nome"],
      type: json["tipo"],
      origin: json["origem"],
      destination: json["destino"], 
      flightCompany: json["cia"],
      flight: json["voo"],
      distance: json["distancia"],
    );
  }
}

class Volunteer{
  late int id;
  late String name;
  late String photo;
  late String role;
  late String email;
  late String telephone;
  late String height;
  late String weight;
  
  Volunteer({
    required this.id,
    required this.name,
    required this.photo,
    required this.role,
    required this.email,
    required this.telephone,
    required this.height,
    required this.weight
  });

  factory Volunteer.fromJson(Map<String, dynamic> json) {
    return Volunteer(
      id: json["id"], 
      name: json["nome"],
      photo: json["photo"],
      role: json["funcao"],
      email: json["email"], 
      telephone: json["telefone"],
      height: json["altura"],
      weight: json["peso"],
    );
  }
}

