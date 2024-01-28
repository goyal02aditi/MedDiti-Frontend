import 'package:flutter/material.dart';
import 'homepage.dart';
import 'rem.dart';
import 'signup_page.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediMate',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: SignUpPage(),
    );
  }
}

class Message {
  final String sender;
  final String text;
  final DateTime timestamp;

  Message({required this.sender, required this.text}) : timestamp = DateTime.now();
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<Message> _messages = [];

  // Inside the _ChatScreenState class
  Future<void> _launchURL(String url) async {
    print(url);
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      print(uri);
      await launchUrl(uri);
    } else {
      print('Could not launch $url');
    }
  }

  Widget _buildMessage(Message message) {
    final bool isMe = message.sender == 'me';

    return Column(
      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          message.timestamp.hour.toString().padLeft(2, '0') +
              ':' +
              message.timestamp.minute.toString().padLeft(2, '0'),
          style: const TextStyle(fontSize: 12),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16.0,
          ),
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: isMe ? Colors.tealAccent.shade100 : Colors.grey[400],
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Linkify(
              onOpen: (link) => _launchURL(link.url),
              text: message.text,
              style: TextStyle(
                color: isMe ? Colors.black : Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _fetchBotResponse(String message) async {
    final String apiUrl = 'http://170.64.147.213:5005/webhooks/rest/webhook';

    final Map<String, dynamic> requestData = {
      'sender': 'user1',
      'message': message,
    };

    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode(requestData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);

      if (jsonResponse.isNotEmpty) {
        final String botResponse = jsonResponse.first['text'];
        _addBotResponse(botResponse);
      }
    } else {
      // Handle error if needed
      print('Failed to fetch bot response. Status code: ${response.statusCode}');
    }
  }

  void _addBotResponse(String response) {
    setState(() {
      _messages.add(Message(sender: 'bot', text: response));
    });
  }

  void _onMessageSubmitted(String message) {
    _textController.clear();
    setState(() {
      _messages.add(Message(sender: 'me', text: message));
    });

    // Fetch response from the chatbot API
    _fetchBotResponse(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MediMate'),
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: Colors.teal.shade700,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                final Message message = _messages[index];
                final bool isMe = message.sender == 'me';
                return _buildMessage(message);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _textController,
                    onFieldSubmitted: _onMessageSubmitted,
                    decoration: InputDecoration(
                      labelText: 'Type your message',
                      labelStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                FloatingActionButton(
                  onPressed: () {
                    _onMessageSubmitted(_textController.text);
                  },
                  backgroundColor: Colors.teal.shade700,
                  child: const Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
      ),
      body: Center(
        child: Text('This is the Main Page'),
      ),
    );
  }
}