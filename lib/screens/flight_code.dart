import 'package:app_ases/screens/welcome_carousel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FlightCode extends StatelessWidget {
  const FlightCode({super.key});

  @override
  Widget build(BuildContext context) {
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
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WelcomeCarousel()),
                  );
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

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
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
                child: Text("Insira seu código de acesso:",
                    style: GoogleFonts.montserrat(
                        fontSize: 15, fontWeight: FontWeight.normal)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 120, right: 120),
                child: TextField(
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
              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 20),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          Theme.of(context).colorScheme.secondary)),
                  onPressed: () {
                    goToHome(context);
                  },
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
                onTap: () {},
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
    );
  }
}
