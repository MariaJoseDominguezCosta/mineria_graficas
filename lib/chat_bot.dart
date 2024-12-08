import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatBot extends StatefulWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  bool _isLoading = false;

  // Función para enviar mensaje al servidor
  Future<void> _sendMessage(String message) async {
    setState(() {
      _isLoading = true;
      _messages.add({'role': 'user', 'message': message});
    });

    try {
      final response = await http.post(
        Uri.parse('https://automakerapi.ngrok.app/chat'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': message}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final botMessage = data['response'] ?? 'No response from server';

        setState(() {
          _messages.add({'role': 'bot', 'message': botMessage});
        });
      } else {
        setState(() {
          _messages.add({
            'role': 'bot',
            'message': 'Error: ${response.statusCode} ${response.reasonPhrase}',
          });
        });
      }
    } on SocketException catch (_) {
      setState(() {
        _messages.add(
            {'role': 'bot', 'message': 'Network error. Check connection.'});
      });
    } catch (e) {
      setState(() {
        _messages.add({'role': 'bot', 'message': 'Error: $e'});
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final message = _messages[index];
              final isUser = message['role'] == 'user';
              return Align(
                alignment:
                    isUser ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: isUser ? Colors.blue[100] : Colors.grey[300],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    message['message'] ?? '',
                    style: TextStyle(
                      color: isUser ? Colors.black : Colors.black54,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        if (_isLoading)
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Ask about 3D printing...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                final message = _controller.text.trim();
                if (message.isNotEmpty) {
                  _sendMessage(message);
                  _controller.clear();
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
