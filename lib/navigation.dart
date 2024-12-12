import 'dart:convert';

import 'package:app_ases/models/flight_info.dart';
import 'package:app_ases/models/user.dart';
import 'package:app_ases/screens/home.dart';
import 'package:app_ases/screens/monitor_flight.dart';
import 'package:app_ases/screens/profile.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  FlightInfo flightInfo;
  UserType userType;
  String flightCode;
  Navigation({super.key, required this.flightInfo, required this.userType, required this.flightCode});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentPageIndex = 0;
  int currentStretch = 0;

  setStretch(int newStretch){
    setState(() {
      currentStretch = newStretch;
    });
  }

  getUserName(){
    if(widget.userType == UserType.patient){
      return widget.flightInfo.patient.name;
    }if(widget.userType == UserType.volunteer){
      return 
        widget.flightInfo.volunteers.where((volunteer) => volunteer.accessCode != '').first.name;
    }else{
      return 
       widget.flightInfo.chaperones.where((chaperone) => chaperone.accessCode != '').first.name;
    }
  }

  bool hasImage(){
    if(widget.userType == UserType.patient){
      return true;
    }else if(widget.userType == UserType.volunteer){
      var loggedUser = widget.flightInfo.volunteers.where((volunteer) => volunteer.accessCode != '');
      return loggedUser.isEmpty ? false: true;
    }else{
      var loggedUser = widget.flightInfo.chaperones.where((chaperone) => chaperone.accessCode != '');
      return loggedUser.isEmpty ? false: true;
    }
  }

  Image getImage(){
    if(widget.userType == UserType.patient){
      return imageFromBase64String(widget.flightInfo.patient.photo);
    }if(widget.userType == UserType.volunteer){
      return imageFromBase64String(
        widget.flightInfo.volunteers.where((volunteer) => volunteer.accessCode != "null").first.photo
      );
    }else{
      return imageFromBase64String(
        widget.flightInfo.chaperones.where((chaperone) => chaperone.accessCode != "null").first.photo
      );
    }
  }

  Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String), height: 100);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      Home(flightInfo: widget.flightInfo,
      userType: widget.userType,
      flightCode: widget.flightCode,
      setStretch: setStretch,
      currentStretch: currentStretch
      ),
      MonitorFlightScreen(
        flightInfo: widget.flightInfo,
        userType: widget.userType,
        flightCode: widget.flightCode,
        setStretch: setStretch,
        currentStretch: currentStretch
      ),
      Profile(
        flightInfo: widget.flightInfo,
        userType: widget.userType,
        flightCode: widget.flightCode,
      ),
    ];

    return Scaffold(
        bottomNavigationBar: NavigationBar(
          backgroundColor: Colors.white,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.home_outlined), label: "Início"),
            NavigationDestination(
                icon: Icon(Icons.flight_outlined), label: "Acompanhamento"),
            NavigationDestination(
                icon: Icon(Icons.person_outline), label: "Perfil")
          ],
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: Theme.of(context).colorScheme.primary,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Column(
                  children: [
                    if(hasImage())...[
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: getImage().image,
                      ),
                    ],
                    const SizedBox(height: 8),
                    Text(
                       "Olá, ${getUserName()}!",
                       style: const TextStyle(
                           fontSize: 20,
                           fontWeight: FontWeight.bold,
                           color: Colors.white),
                    ),
                    Text(
                      User.getUserTypeDescription(widget.userType),
                      style:
                          const TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(child: widgetOptions.elementAt(currentPageIndex)),
            ]));
  }
}
