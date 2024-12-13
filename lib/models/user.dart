class User {
  final String name;
  final UserType type;
  String flightInfo;

  User(
      {required this.name,
      required this.type,
      required this.flightInfo});

  getUserName() {
    return name;
  }

  static UserType getUserTypeWithDescription(String userType) { //retorna o tipo de usuário
    if (userType == 'Paciente') {
      return UserType.patient;
    } else if (userType == 'Acompanhante') {
      return UserType.chaperone;
    } else {
      return UserType.volunteer;
    }
  }

  static String getUserTypeDescription(UserType userType) { //retorna a descrição do tipo de usuário
    if (userType == UserType.patient) {
      return 'Paciente';
    } else if (userType == UserType.chaperone) {
      return 'Acompanhante';
    } else {
      return 'Voluntario';
    }
  }
}

enum UserType { patient, chaperone, volunteer }
