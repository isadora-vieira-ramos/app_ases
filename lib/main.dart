import 'package:app_ases/screens/flight_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final ThemeData theme = ThemeData();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Monitoramento de Acionamento Ases',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFEFEFEF),
          colorScheme: theme.colorScheme.copyWith(
            primary: const Color(0xff64CCF3),
            secondary: const Color(0xff01AFEF),
            tertiary: const Color(0xffAECF8A),
          )),
      home: const FlightCode(),
    );
  }
}
