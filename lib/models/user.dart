class User {
  final String name;
  final UserType type;
  final String telephone;
  final String address;

  User(
      {required this.name,
      required this.type,
      required this.telephone,
      required this.address});

  getUserName() {
    return name;
  }

  static UserType getUserType(String userType) {
    if (userType == 'Paciente') {
      return UserType.patient;
    } else if (userType == 'Acompanhante') {
      return UserType.chaperone;
    } else {
      return UserType.volunteer;
    }
  }

  static String getUserTypeDescription(UserType userType) {
    if (userType == UserType.patient) {
      return 'Paciente';
    } else if (userType == UserType.chaperone) {
      return 'Acompanhante';
    } else {
      return 'Voluntário';
    }
  }
}

enum UserType { patient, chaperone, volunteer }
