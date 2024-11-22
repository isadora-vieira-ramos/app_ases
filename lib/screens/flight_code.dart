import 'package:app_ases/models/flight_info.dart';
import 'package:app_ases/models/user.dart';
import 'package:app_ases/screens/welcome_carousel.dart';
import 'package:app_ases/services/flight_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_ases/navigation.dart';

class FlightCode extends StatefulWidget {
  const FlightCode({super.key});

  @override
  State<FlightCode> createState() => _FlightCodeState();
}

class _FlightCodeState extends State<FlightCode> {
  FlightService service = FlightService();
  FlightInfo? flightInfo;
  String? selectedValue;
  String? flightCode;
  String? errorMessage;

  void goToHome(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.all(16.0),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.6,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Termo de Uso de Imagem',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Eu, declaro que li, entendi e concordo com as condições estabelecidas para o uso dos meus dados pessoais, conforme descrito abaixo, de acordo com a Lei Geral de Proteção de Dados Pessoais (LGPD):",
                    style: GoogleFonts.montserrat(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Eu autorizo a coleta e o tratamento dos meus dados pessoais, incluindo, mas não se limitando a, fotos, mensagens e outros dados necessários para o funcionamento do serviço.",
                    style: GoogleFonts.montserrat(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Entendo que fotos e mensagens poderão ser armazenadas conforme necessário para a prestação dos serviços e funcionalidades do aplicativo.",
                    style: GoogleFonts.montserrat(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Estou ciente de que posso exercer meus direitos sobre meus dados pessoais a qualquer momento.",
                    style: GoogleFonts.montserrat(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey[200],
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.block, color: Colors.grey),
                  const SizedBox(width: 5),
                  Text(
                    'Discordo',
                    style: GoogleFonts.montserrat(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                if (selectedValue == 'Paciente' ||
                    selectedValue == 'Acompanhante') {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WelcomeCarousel(
                            flightInfo: flightInfo!,
                            userType: User.getUserType(selectedValue!))),
                  );
                } else {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Navigation(
                            flightInfo: flightInfo!,
                            userType: User.getUserType(selectedValue!))),
                  );
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.check, color: Colors.white),
                  const SizedBox(width: 5),
                  Text(
                    'Concordo',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void validateAndSubmit(BuildContext context) async {
    setState(() {
      errorMessage = null;
    });

    if (selectedValue == null || flightCode == null || flightCode!.isEmpty) {
      setState(() {
        errorMessage = 'Por favor, preencha todos os campos.';
      });
    } else {
      var currentUser = User.getUserType(selectedValue!);

      flightInfo = await service.fetchFlightInfo(currentUser, flightCode!);
      if (flightInfo != null) {
        goToHome(context);
      } else {
        setState(() {
          errorMessage =
              'Não foi possível encontrar as informações dessa viagem. Verifique-se o código está correto.';
        });
      }
    }
  }

  void showRecoveryMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Esqueceu seu código de acesso?'),
          content: const Text(
              "Para recuperá-lo, entre em contato com a equipe da ASES:\n"
              "- 🌐 asesbrasil.org.br\n"
              "- 📱 WhatsApp: (12) 98102-0346\n\n"
              "Estamos aqui para ajudar você!"),
          actions: <Widget>[
            TextButton(
              child: const Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('lib/images/logo.png', width: 200, height: 150),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Acompanhamento de acionamento ASES",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Selecione o tipo de usuário:",
                        style: GoogleFonts.montserrat(
                            fontSize: 15, fontWeight: FontWeight.normal)),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, bottom: 2, top: 2),
                      child: DropdownButton(
                        underline: const SizedBox(),
                        value: selectedValue,
                        items: <String>['Paciente', 'Acompanhante', 'Voluntário']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            alignment: Alignment.centerLeft,
                            child: Text(value,
                                style: const TextStyle(color: Colors.grey)),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            selectedValue = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Insira seu código de acesso:",
                        style: GoogleFonts.montserrat(
                            fontSize: 15, fontWeight: FontWeight.normal)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 120, right: 120),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          flightCode = value;
                        });
                      },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20.0)),
                          hintText: "Ex: 1245AQ6",
                          hintStyle: const TextStyle(color: Colors.grey)),
                    ),
                  ),
                  if (errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        errorMessage!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 20),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).colorScheme.secondary)),
                      onPressed: () => validateAndSubmit(context),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Entrar",
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: showRecoveryMessage,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text('Esqueci meu código',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
