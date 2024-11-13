class User{
  final String name;
  final UserType type;
  final String telephone;
  final String address;

  User({required this.name, required this.type, required this.telephone, required this.address});

  getUserName(){
    return name;
  }
}

enum UserType { passenger, pilot, admin }