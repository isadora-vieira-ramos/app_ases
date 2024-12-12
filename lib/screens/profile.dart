import 'package:app_ases/models/flight_info.dart';
import 'package:app_ases/models/user.dart';
import 'package:app_ases/screens/welcome_carousel.dart'; // Certifique-se de importar a tela correta.
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  FlightInfo flightInfo;
  UserType userType;
  String flightCode;
  Profile({super.key, required this.flightInfo, required this.userType, required this.flightCode});

  String getUsername(){
    if(userType == UserType.patient){
      return flightInfo.patient.name;
    }else if(userType == UserType.volunteer){
      var loggedUser = flightInfo.volunteers.where((volunteer) => volunteer.accessCode != '');
      return loggedUser.first.name;
    }else {
      var loggedUser = flightInfo.chaperones.where((chaperone) => chaperone.accessCode != '');
      return loggedUser.first.name;
    }
  }

  String getTelephone(){
    if(userType == UserType.patient){
      return flightInfo.patient.telephone;
    }else if(userType == UserType.volunteer){
      var loggedUser = flightInfo.volunteers.where((volunteer) => volunteer.accessCode != '');
      return loggedUser.first.telephone;
    }else {
      var loggedUser = flightInfo.chaperones.where((chaperone) => chaperone.accessCode != '');
      return loggedUser.first.telephone;
    }
  }

  String getAddress(){
    if(userType == UserType.patient){
      String addressDetails = flightInfo.accomodation.additionalAddressDetails.isEmpty? '': "${flightInfo.accomodation.additionalAddressDetails},"; 
      return "${flightInfo.patient.address}, ${flightInfo.patient.number}, ${addressDetails} ${flightInfo.patient.district}, ${flightInfo.patient.city}, ${flightInfo.patient.state}";
    }else {
      var loggedUser = flightInfo.chaperones.where((chaperone) => chaperone.accessCode != '').first;
      String addressDetails = loggedUser.additionalAddressDetails.isEmpty? '': "${loggedUser.additionalAddressDetails},"; 
      return "${loggedUser.address}, ${loggedUser.number}, ${addressDetails} ${loggedUser.district}, ${loggedUser.city}, ${loggedUser.state}";
    }
  }

  String getAccommodation(){
    String addressDetails = flightInfo.accomodation.additionalAddressDetails.isEmpty? '': "${flightInfo.accomodation.additionalAddressDetails},"; 
    return "${flightInfo.accomodation.name}\n${flightInfo.accomodation.address}, ${flightInfo.accomodation.number}, ${addressDetails} ${flightInfo.accomodation.district}, ${flightInfo.accomodation.city}, ${flightInfo.accomodation.state}";
  }

  String getRole(){
    var loggedUser = flightInfo.volunteers.where((chaperone) => chaperone.accessCode != '');
      return loggedUser.first.role;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      'Dados do Usuário',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Text(
                    'Nome:',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide.none,
                        ),
                        hintText: getUsername(),
                        hintStyle: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  const Text(
                    'Telefone:',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide.none,
                        ),
                        hintText: getTelephone(),
                        hintStyle: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  if(userType != UserType.volunteer)...[
                    const Text(
                      'Endereço:',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextField(
                        readOnly: true,
                        minLines: 1,
                        maxLines: 3,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide.none,
                          ),
                          hintText: getAddress(),
                          hintStyle: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    const Text(
                      'Hospedagem:',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextField(
                        readOnly: true,
                        minLines: 1,
                        maxLines: 3,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide.none,
                          ),
                          hintText: getAccommodation(),
                          hintStyle: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                  if(userType == UserType.volunteer)...[
                    const Text(
                      'Função:',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide.none,
                          ),
                          hintText: getRole(),
                          hintStyle: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WelcomeCarousel(
                          flightInfo: flightInfo,
                          userType: userType,
                          flightCode: flightCode,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      textStyle: const TextStyle(fontSize: 18),
                      backgroundColor: Theme.of(context).colorScheme.secondary),
                  child: const Text(
                    'Orientações',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
