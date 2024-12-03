import 'package:app_ases/services/flight_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatWidget extends StatefulWidget {
  final String apiUrl;
  final String token;
  final String codigo;
  final int acionamentoId;
  final int origemId; // Adicionado para filtrar mensagens por ORIGEM_ID

  const ChatWidget({
    super.key,
    required this.apiUrl,
    required this.token,
    required this.codigo,
    required this.acionamentoId,
    required this.origemId,
  });

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  List<Map<String, dynamic>> messages = [];
  FlightService flightService = FlightService();
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  Future<void> fetchMessages() async {
    var json = jsonEncode({
      "TOKEN": widget.token,
      "TIPO": "PACIENTE",
      "CODIGO": widget.codigo,
      "ACIONAMENTO_ID": widget.acionamentoId,
    });

    final response = await http.post(
      Uri.parse('${widget.apiUrl}/api_get_messages/index.php'), // URL correta
      headers: {'Content-Type': 'application/json'},
      body: json,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        // Filtrando mensagens pelo ORIGEM_ID
        messages = List<Map<String, dynamic>>.from(data['MENSAGEMS'])
            .where((message) => message['ORIGEM_ID'] == widget.origemId)
            .toList();
      });
    } else {
      print('Failed to load messages');
    }
  }

  Future<void> deleteMessage(int messageId) async {
    final response = await http.post(
      Uri.parse(
          '${widget.apiUrl}/api_delete_message/index.php'), // Atualizar para o endpoint correto
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "TOKEN": widget.token,
        "TIPO": "PACIENTE",
        "CODIGO": widget.codigo,
        "ACIONAMENTO_ID": widget.acionamentoId,
        "MENSAGEM_ID": messageId, // ID da mensagem a ser excluída
      }),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result['STATUS'] == 200) {
        setState(() {
          messages.removeWhere((message) => message['ID'] == messageId);
        });
        print('Mensagem deletada com sucesso.');
      } else {
        print('Erro: ${result['MESSAGE']}');
      }
    } else {
      print('Erro ao deletar a mensagem.');
    }
  }

  Future<void> sendMessage(String message) async {
    final response = await http.post(
      Uri.parse('${widget.apiUrl}/api_send_message/index.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "TOKEN": widget.token,
        "TIPO": "PACIENTE",
        "CODIGO": widget.codigo,
        "ACIONAMENTO_ID": widget.acionamentoId,
        "TRECHO": 1,
        "DATA_COLETA": DateTime.now().toIso8601String(),
        "MENSAGEM": message,
        "FOTO": "MENSAGEM"
      }),
    );

    if (response.statusCode == 200) {
      messageController.clear();
      fetchMessages(); // Refresh messages after sending
    } else {
      print('Failed to send message');
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
                    onPressed: () {},
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
