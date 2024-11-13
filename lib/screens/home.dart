import 'package:app_ases/screens/flight_code.dart';
import 'package:app_ases/utils/action_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [ActionBar(takePhoto: true, updatePosition: () {})],
    ));
  }
}
