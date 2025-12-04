import 'package:flutter/foundation.dart';
import '../models/chat_message.dart';

class ChatService extends ChangeNotifier {
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;

  List<ChatMessage> get messages => List.unmodifiable(_messages);
  bool get isLoading => _isLoading;

  // Predefined responses for demo
  final Map<String, String> _responses = {
    'jak investovat': 'Pro začátek doporučuji diverzifikované ETF fondy. Začněte s malou částkou a postupně ji zvyšujte. Důležité je investovat pravidelně a dlouhodobě.',
    'tipy na úspory': 'Zkuste pravidlo 50/30/20: 50% na potřeby, 30% na přání a 20% na úspory. Také doporučuji automatické převody na spořicí účet hned po výplatě.',
    'vysvětli etf': 'ETF (Exchange Traded Fund) je fond obchodovaný na burze, který sleduje výkonnost určitého indexu, sektoru nebo aktiva. Je to skvělý způsob, jak diverzifikovat portfolio s nízkými poplatky.',
    'default': 'Díky za dotaz! Jako váš finanční asistent vám rád pomohu s investicemi, rozpočtem, kryptoměnami nebo dluhy. Co vás konkrétně zajímá?',
  };

  void sendMessage(String text) {
    // Add user message
    _messages.add(ChatMessage(
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
    ));
    notifyListeners();

    // Simulate processing
    _isLoading = true;
    notifyListeners();

    // Generate response
    Future.delayed(const Duration(milliseconds: 800), () {
      final response = _getResponse(text.toLowerCase());
      _messages.add(ChatMessage(
        text: response,
        isUser: false,
        timestamp: DateTime.now(),
      ));
      _isLoading = false;
      notifyListeners();
    });
  }

  String _getResponse(String query) {
    for (var key in _responses.keys) {
      if (query.contains(key)) {
        return _responses[key]!;
      }
    }
    return _responses['default']!;
  }

  void clearMessages() {
    _messages.clear();
    notifyListeners();
  }
}
