import 'package:app_ases/models/flight_info.dart';
import 'package:app_ases/models/user.dart';
import 'package:app_ases/navigation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeCarousel extends StatefulWidget {
  FlightInfo flightInfo;
  UserType userType;
  String flightCode;
  WelcomeCarousel(
      {super.key, required this.flightInfo, required this.userType, required this.flightCode});

  @override
  WelcomeCarouselState createState() => WelcomeCarouselState();
}

class WelcomeCarouselState extends State<WelcomeCarousel> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: PageView(
                allowImplicitScrolling: true,
                controller: _controller,
                onPageChanged: (page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: [
                  _carouselPage(
                    context,
                    title: 'Bem-vindo(a) a Bordo!',
                    content:
                        '''O ASES é uma rede de voluntários sem fins lucrativos, que possibilita transporte aéreo voluntário e gratuito de passageiros envolvidas em tratamento médico longe de casa. 
            
            Usamos aeronaves particulares, corporativas de transporte público para levar passageiros que encontram tratamento adequado nos centros de excelência em saúde distantes de seus domicilios. Assim, buscamos dar asas ao amor, colaborando para encurtar a distância entre o lar e a esperança.
            
            Estamos entusiasmados por tê-lo(a) conosco em uma missão humanitária. Antes de decolar, garantimos que você tenha todas as informações necessárias para uma experiência tranquila e agradável.''',
                    isFirstPage: true,
                  ),
                  _carouselPage(
                    context,
                    title: 'Vamos preparar nosso voo!',
                    content:
                        '''O ASES tem o orgulho de participar desta ação humanitária e queremos que sua experiência seja a mais agradável possível. Apresentamos um checklist e orientações para que você esteja preparado para o voo.''',
                    isFirstPage: false,
                  ),
                  _carouselPage(
                    context,
                    title:
                        'Aguarde o contato prévio da coordenação e dos tripulantes',
                    content:
                        '''A coordenação ASES manterá contato direto com você, esclarecendo qualquer dúvida e fornecendo detalhes sobre sua viagem, além de atualizações relevantes. Essa comunicação garantirá um planejamento tranquilo e sem contratempos.
            
            O voo é cuidadosamente planejado para que, caso ocorra algum imprevisto ou por condições meteorológicas, você ainda tenha a opção de realizar sua viagem via modal terrestre, se nossa equipe considerar que isso seja mais seguro.
            
            Com pelo menos um dia de antecedência, o piloto responsável entrará em contato para confirmar os horários, o ponto de encontro e fornecer informações adicionais. Aproveite esse momento para esclarecer qualquer dúvida que possa ter.
            
            Caso algum ASES do asfalto esteja disponível para realizar o transporte, ele entrará em contato para coordenar o ponto de encontro e o horário do translado até o aeroporto.''',
                    isFirstPage: false,
                  ),
                  _carouselPage(
                    context,
                    title: 'Organize suas malas e prepare-se com antecedência',
                    content:
                        '''No dia anterior ao voo, faça refeições leves e equilibradas para garantir uma alimentação saudável. Além disso, descanse adequadamente, assegurando uma boa noite de sono, para estar disposto(a) e preparado(a) no dia do voo.
            
            Organize suas malas com antecedência, lembrando que cada passageiro pode levar 1 bolsa de mão e 1 mala pequena.
            
            Verifique se todos os itens essenciais estão prontos na noite anterior para evitar contratempos no dia do voo.
            
            Nota importante: Siga as orientações que o piloto passou em relação às bagagens, pois há uma limitação de peso na aeronave. Sempre que possível, opte por malas flexíveis em vez de rígidas, já que o espaço pode ser restrito e as dimensões das bagagens rígidas podem dificultar o armazenamento.''',
                    isFirstPage: false,
                  ),
                  _carouselPage(
                    context,
                    title: 'Opte por vestimentas confortáveis para o voo',
                    content:
                        '''Mesmo em dias quentes, carregue um casaco leve, pois as temperaturas nas altitudes dos voos tendem a ser mais baixas. Ter um casaco à mão garantirá que você permaneça confortável durante toda a viagem.
            
            Dê prioridade a roupas confortáveis para que você possa aproveitar a experiência sem desconfortos.
            
            É recomendável o uso de sapatos fechados, pois eles proporcionam maior segurança nas operações.''',
                    isFirstPage: false,
                  ),
                  _carouselPage(
                    context,
                    title: 'No dia do seu voo ASES',
                    content:
                        '''No local combinado, o piloto estará à sua espera e, antes do início do voo, realizará uma breve conversa explicativa sobre a viagem. Sinta-se à vontade para tirar suas dúvidas, se necessário. 
            
            Durante essa conversa, serão discutidas as condições e a previsão do tempo para o voo, além das instruções de segurança e do acompanhamento até o embarque da aeronave. 
            
            Não se esqueça de portar a sua documentação de identificação.''',
                    isFirstPage: false,
                  ),
                  _carouselPage(
                    context,
                    title: 'Aproveite seu voo ASES e compartilhe as lembranças',
                    content:
                        '''No local combinado, o piloto estará à sua espera e, antes do início do voo, realizará uma breve conversa explicativa sobre a viagem. Sinta-se à vontade para tirar suas dúvidas, se necessário. 
            
            Durante essa conversa, serão discutidas as condições e a previsão do tempo para o voo, além das instruções de segurança e do acompanhamento até o embarque da aeronave. 
            
            Não se esqueça de portar a sua documentação de identificação. Antes da decolagem será oferecido alguns snacks, que você pode consumir a qualquer momento. Se preferir, sinta-se à vontade para levar algo de casa para complementar sua refeição durante o voo.
            
            Qualquer dúvida em voo siga as orientações passadas pelos tripulantes. 
            
            Esperamos que você tenha uma experiência agradável e memorável! Faça diversos registros para eternizar os momentos especiais e compartilhe suas experiências com a equipe ASES.''',
                    isFirstPage: false,
                  ),
                  // Aqui é a última página, onde adicionamos o botão "Começar"
                  _carouselPage(
                    context,
                    title: 'Prepare-se para a jornada!',
                    content:
                        'Agora que você tem todas as informações necessárias, clique abaixo para iniciar a sua jornada com a ASES.',
                    isFirstPage: false,
                    isLastPage: true,
                  ),
                ],
              ),
            ),
            // Exibe o botão "Começar" apenas na última página
            if (_currentPage == 7) ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          Theme.of(context).colorScheme.secondary)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Navigation(
                              flightInfo: widget.flightInfo,
                              userType: widget.userType,
                              flightCode: widget.flightCode,)),
                    );
                  },
                  child: Text(
                    'Começar!',
                    style: GoogleFonts.montserrat(
                        fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ] else ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Arraste para o lado",
                    style: GoogleFonts.montserrat(
                        fontSize: 20, color: Colors.white),
                  ),
                  const Icon(
                    Icons.arrow_right_alt,
                    color: Colors.white,
                    size: 50,
                  )
                ],
              )
            ]
          ],
        ),
      ),
    );
  }

  Widget _carouselPage(BuildContext context,
      {required String title,
      required String content,
      required bool isFirstPage,
      bool isLastPage = false}) {
    List<String> contentList =
        content.split('\n'); // Dividir o conteúdo em parágrafos

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('lib/images/logo.png', width: 100, height: 100),
            const SizedBox(height: 20),

            // Container para o título e o primeiro parágrafo
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Parágrafos do conteúdo
                  SingleChildScrollView(
                    // Adiciona rolagem para o conteúdo
                    child: Column(
                      children: contentList
                          .map((text) => Padding(
                                padding: const EdgeInsets.only(bottom: 6.0),
                                child: Text(
                                  text,
                                  textAlign: TextAlign.justify,
                                  style: GoogleFonts.montserrat(fontSize: 16),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),

            // Adiciona o segundo container somente na primeira página
            if (isFirstPage)
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Para mais detalhes, acesse nosso site asesbrasil.org.br ou entre em contato pelo Whatsapp (12) 98102 0346.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Prepare-se para uma jornada especial!',
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.montserrat(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
