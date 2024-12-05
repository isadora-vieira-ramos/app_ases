import 'package:app_ases/models/flight_info.dart';
import 'package:app_ases/models/user.dart';
import 'package:app_ases/services/flight_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:image_picker/image_picker.dart';

class ChatWidget extends StatefulWidget {
  final UserType userType;
  final String userCode;
  final FlightInfo flightInfo;
  final int origemId; // Adicionado para filtrar mensagens por ORIGEM_ID
  final int currentStretch;

  const ChatWidget({
    super.key,
    required this.userType,
    required this.userCode,
    required this.flightInfo,
    required this.origemId,
    required this.currentStretch
  });

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  List<Map<String, dynamic>> messages = [];
  FlightService flightService = FlightService();
  final ImagePicker picker = ImagePicker();
  TextEditingController messageController = TextEditingController();
  String currentLoadedImage = "";
  
  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  Future<void> fetchMessages() async {
    final response = await flightService.fetchMessages(
      widget.userType, widget.flightInfo, 
      widget.userCode, 9);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        // Filtrando mensagens pelo ORIGEM_ID
        messages = List<Map<String, dynamic>>.from(data['MENSAGEMS'])
            .where((message) => message['ORIGEM_ID'] == widget.origemId)
            .toList();
      });
    } else {
      Fluttertoast.showToast(
          msg: "Não foi possível carregar as mensagens/fotos",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Theme.of(context).colorScheme.primary,
          textColor: Colors.white,
        );
    }
  }

  Future<void> deleteMessage(int messageId) async {
    final response = await http.post(
      Uri.parse(
          '${dotenv.env['API_URL'].toString()}/api_delete_message/index.php'), // Atualizar para o endpoint correto
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "TOKEN": dotenv.env['TOKEN'].toString(),
        "TIPO": "PACIENTE",
        "CODIGO": widget.userCode,
        "ACIONAMENTO_ID": widget.flightInfo.id,
        "MENSAGEM_ID": messageId, // ID da mensagem a ser excluída
      }),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result['status'] == 200) {
        setState(() {
          messages.removeWhere((message) => message['ID'] == messageId);
        });
        print('Mensagem deletada com sucesso.');
      } else {
        print('Erro: ${result['message']}');
      }
    } else {
      print('Erro ao deletar a mensagem.');
    }
  }

  Future<void> sendMessage(String message) async {

    final response = await flightService.sendMessageAndPhoto(
      widget.userType, widget.userCode, 
      widget.flightInfo, currentLoadedImage, message, widget.currentStretch + 1);

    if (response.statusCode == 200) {
      messageController.clear();
      fetchMessages(); // Refresh messages after sending
    } else {
      Fluttertoast.showToast(
          msg: "Não foi possível enviar a mensagem/foto",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Theme.of(context).colorScheme.primary,
          textColor: Colors.white,
        );
    }
  }

  Future<void> loadImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final String extension = image.name.split('.').last.toLowerCase();
      if (extension == 'jpg' || extension == 'jpeg' || extension == 'png') {
        final bytes = await image.readAsBytes();
        currentLoadedImage = base64Encode(bytes);
        Fluttertoast.showToast(
          msg: "Imagem carregada com sucesso. Escreva uma mensagem para enviar junto ou envie só a foto",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Theme.of(context).colorScheme.primary,
          textColor: Colors.white,
        );
      }else{
        Fluttertoast.showToast(
          msg: "Formato inválido",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Theme.of(context).colorScheme.primary,
          textColor: Colors.white,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 20, bottom: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Chat",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary),
                  textAlign: TextAlign.left),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return ListTile(
                    title: Text(message['MENSAGEM'] ?? 'No message'),
                    subtitle: Text(
                        'Enviado por: ${message['ORIGEM'] ?? 'Desconhecido'}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          message['DATA_HORA'] ?? '',
                          style:
                              const TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            // Confirmar a exclusão
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Confirmação'),
                                content: const Text(
                                    'Deseja realmente excluir esta mensagem?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      deleteMessage(message['ID']);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Excluir'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        labelText: 'Digite sua mensagem...',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add_photo_alternate,
                        color: Theme.of(context).colorScheme.primary),
                    onPressed: loadImage,
                  ),
                  IconButton(
                    icon: Icon(Icons.send,
                        color: Theme.of(context).colorScheme.primary),
                    onPressed: () {
                      if (messageController.text.isNotEmpty) {
                        sendMessage(messageController.text);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
