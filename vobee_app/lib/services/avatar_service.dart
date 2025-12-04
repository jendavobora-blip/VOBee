import 'package:flutter/foundation.dart';

class AvatarService extends ChangeNotifier {
  bool _isSpeaking = false;
  bool _isListening = false;
  String _statusMessage = 'Připraven vám pomoci';

  bool get isSpeaking => _isSpeaking;
  bool get isListening => _isListening;
  String get statusMessage => _statusMessage;

  void startSpeaking() {
    _isSpeaking = true;
    _isListening = false;
    _statusMessage = 'Odpovídám...';
    notifyListeners();
  }

  void stopSpeaking() {
    _isSpeaking = false;
    _statusMessage = 'Připraven vám pomoci';
    notifyListeners();
  }

  void startListening() {
    _isListening = true;
    _isSpeaking = false;
    _statusMessage = 'Poslouchám váš dotaz...';
    notifyListeners();
  }

  void stopListening() {
    _isListening = false;
    _statusMessage = 'Připraven vám pomoci';
    notifyListeners();
  }

  void setStatus(String message) {
    _statusMessage = message;
    notifyListeners();
  }
}
