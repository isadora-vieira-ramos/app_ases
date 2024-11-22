class ResponseJson {
  final FlightInfo flightInfo;

  ResponseJson({required this.flightInfo});

  factory ResponseJson.fromJson(Map<String, dynamic> json) {
    return ResponseJson(
      flightInfo: FlightInfo.fromJson(json['ACIONAMENTO']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ACIONAMENTO': flightInfo.toJson(),
    };
  }
}

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
  late Accommodation accomodation;
  late List<PatientOrChaperone> chaperones;
  late Airplane airplane;
  late List<Stretch> stretchs;
  late List<Volunteer> volunteers;

  FlightInfo(
      {required this.id,
      required this.bookingCode,
      required this.status,
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
      required this.volunteers});

  factory FlightInfo.fromJson(Map<String, dynamic> json) {
    var chaperoneList = json['ACOMPANHANTES'] as List;
    List<PatientOrChaperone> chaperones =
        chaperoneList.map((i) => PatientOrChaperone.fromJson(i)).toList();

    var stretchList = json['TRECHOS'] as List;
    List<Stretch> stretchs =
        stretchList.map((i) => Stretch.fromJson(i)).toList();

    var volunteerList = json['VOLUNTARIOS'] as List;
    List<Volunteer> volunteers =
        volunteerList.map((i) => Volunteer.fromJson(i)).toList();

    return FlightInfo(
        id: json['ID'],
        bookingCode: json['ACIONAMENTO'],
        status: json['STATUS'],
        departureDate: json['DATA_IDA'],
        returnDate: json['DATA_RETORNO'],
        origin: json['CIDADE_ORIGEM'],
        destination: json['CIDADE_DESTINO'],
        patient: PatientOrChaperone.fromJson(json['PACIENTE']),
        hospital: Hospital.fromJson(json['HOSPITAL']),
        accomodation: Accommodation.fromJson(json['HOSPEDAGEM']),
        chaperones: chaperones,
        airplane: Airplane.fromJson(json['AERONAVE']),
        stretchs: stretchs,
        volunteers: volunteers);
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'ACIONAMENTO': bookingCode,
      'STATUS': status,
      'DATA_IDA': departureDate,
      'DATA_RETORNO': returnDate,
      'CIDADE_ORIGEM': origin,
      'CIDADE_DESTINO': destination,
      'PACIENTE': patient,
      'HOSPITAL': hospital,
      'HOSPEDAGEM': accomodation,
      'ACOMPANHANTES': chaperones,
      'AERONAVE': airplane,
      'TRECHOS': stretchs,
      'VOLUNTARIOS': volunteers
    };
  }
}

class PatientOrChaperone {
  late int id;
  late String name;
  late int age;
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

  PatientOrChaperone(
      {required this.id,
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
      required this.longitude});

  factory PatientOrChaperone.fromJson(Map<String, dynamic> json) {
    return PatientOrChaperone(
        id: json['ID'],
        name: json['NOME'],
        age: json['IDADE'],
        email: json['DOCUMENTO'],
        telephone: json['TELEFONE'],
        height: json['ALTURA'],
        weight: json['PESO'],
        photo: json['FOTO'],
        zipCode: json['CEP'],
        address: json['ENDERECO'],
        number: json['NUMERO'],
        additionalAddressDetails: json['COMPLEMENTO'],
        district: json['BAIRRO'],
        city: json['CIDADE'],
        state: json['ESTADO'],
        latitude: json['LATITUDE'],
        longitude: json['LONGITUDE']);
  }
}

class Hospital {
  late int id;
  late String name;
  late String healthOfficial;
  late String? photo;
  late String zipCode;
  late String address;
  late String number;
  late String additionalAddressDetails;
  late String district;
  late String city;
  late String state;
  late String? latitude;
  late String? longitude;

  Hospital(
      {required this.id,
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
      required this.longitude});

  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
        id: json['ID'],
        name: json['HOSPITAL'],
        healthOfficial: json['CONTATO'],
        photo: json['FOTO'] ?? 'null',
        zipCode: json['CEP'],
        address: json['ENDERECO'],
        number: json['NUMERO'],
        additionalAddressDetails: json['COMPLEMENTO'],
        district: json['BAIRRO'],
        city: json['CIDADE'],
        state: json['ESTADO'],
        latitude: json['LATITUDE'] ?? 'null',
        longitude: json['LONGITUDE'] ?? 'null');
  }
}

class Accommodation {
  late int id;
  late String name;
  late String contactPerson;
  late String? photo;
  late String zipCode;
  late String address;
  late String number;
  late String additionalAddressDetails;
  late String district;
  late String city;
  late String state;
  late String? latitude;
  late String? longitude;

  Accommodation(
      {required this.id,
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
      required this.longitude});

  factory Accommodation.fromJson(Map<String, dynamic> json) {
    return Accommodation(
        id: json['ID'],
        name: json['HOSPEDAGEM'],
        contactPerson: json['CONTATO'],
        photo: json['FOTO'] ?? 'null',
        zipCode: json['CEP'],
        address: json['ENDERECO'],
        number: json['NUMERO'],
        additionalAddressDetails: json['COMPLEMENTO'],
        district: json['BAIRRO'],
        city: json['CIDADE'],
        state: json['ESTADO'],
        latitude: json['LATITUDE'] ?? 'null',
        longitude: json['LONGITUDE'] ?? 'null');
  }
}

class Airplane {
  late String prefix;
  late String manufacturer;
  late String type;
  late String model;
  late String name;
  late String engine;
  late int speed;
  late String color;
  late String photo;

  Airplane(
      {required this.prefix,
      required this.manufacturer,
      required this.type,
      required this.model,
      required this.name,
      required this.engine,
      required this.speed,
      required this.color,
      required this.photo});

  factory Airplane.fromJson(Map<String, dynamic> json) {
    return Airplane(
      prefix: json['PREFIXO'],
      manufacturer: json['FABRICANTE'],
      type: json['TIPO'],
      model: json['MODELO'],
      name: json['NOME'],
      engine: json['MOTOR'],
      speed: json['VELOCIDADE'],
      color: json['COR'],
      photo: json['FOTO'] ?? 'null',
    );
  }
}

class Stretch {
  late int id;
  late String stretchName;
  late String type;
  late String origin;
  late String destination;
  late String flightCompany;
  late String flight;
  late int distance;
  late String duration;

  Stretch(
      {required this.id,
      required this.stretchName,
      required this.type,
      required this.origin,
      required this.destination,
      required this.flightCompany,
      required this.flight,
      required this.distance,
      required this.duration});

  factory Stretch.fromJson(Map<String, dynamic> json) {
    return Stretch(
        id: json['TRECHO'],
        stretchName: json['NOME'],
        type: json['TIPO'],
        origin: json['ORIGEM'],
        destination: json['DESTINO'],
        flightCompany: json['CIA'],
        flight: json['VOO'],
        distance: json['DISTANCIA'],
        duration: json['DURACAO']);
  }
}

class Volunteer {
  late int id;
  late String name;
  late String photo;
  late String role;
  late String email;
  late String telephone;
  late String height;
  late String weight;

  Volunteer(
      {required this.id,
      required this.name,
      required this.photo,
      required this.role,
      required this.email,
      required this.telephone,
      required this.height,
      required this.weight});

  factory Volunteer.fromJson(Map<String, dynamic> json) {
    return Volunteer(
      id: json['ID'],
      name: json['NOME'],
      photo: json['FOTO'],
      role: json['FUNCAO'],
      email: json['EMAIL'],
      telephone: json['TELEFONE'],
      height: json['ALTURA'],
      weight: json['PESO'],
    );
  }
}
