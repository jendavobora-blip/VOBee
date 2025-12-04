import 'package:flutter_test/flutter_test.dart';
import 'package:vobee_app/models/chat_message.dart';
import 'package:vobee_app/services/chat_service.dart';
import 'package:vobee_app/services/avatar_service.dart';

void main() {
  group('ChatMessage', () {
    test('should create ChatMessage with correct properties', () {
      final now = DateTime.now();
      final message = ChatMessage(
        text: 'Hello',
        isUser: true,
        timestamp: now,
      );

      expect(message.text, 'Hello');
      expect(message.isUser, true);
      expect(message.timestamp, now);
    });

    test('should convert to JSON correctly', () {
      final now = DateTime(2024, 1, 1, 12, 0, 0);
      final message = ChatMessage(
        text: 'Test message',
        isUser: false,
        timestamp: now,
      );

      final json = message.toJson();
      expect(json['text'], 'Test message');
      expect(json['isUser'], false);
      expect(json['timestamp'], '2024-01-01T12:00:00.000');
    });

    test('should create from JSON correctly', () {
      final json = {
        'text': 'From JSON',
        'isUser': true,
        'timestamp': '2024-01-01T12:00:00.000',
      };

      final message = ChatMessage.fromJson(json);
      expect(message.text, 'From JSON');
      expect(message.isUser, true);
    });
  });

  group('ChatService', () {
    late ChatService chatService;

    setUp(() {
      chatService = ChatService();
    });

    test('should start with empty messages', () {
      expect(chatService.messages.isEmpty, true);
    });

    test('should not be loading initially', () {
      expect(chatService.isLoading, false);
    });

    test('should add message when sendMessage is called', () {
      chatService.sendMessage('Test message');
      expect(chatService.messages.length, 1);
      expect(chatService.messages.first.text, 'Test message');
      expect(chatService.messages.first.isUser, true);
    });

    test('should clear all messages', () {
      chatService.sendMessage('Message 1');
      chatService.clearMessages();
      expect(chatService.messages.isEmpty, true);
    });
  });

  group('AvatarService', () {
    late AvatarService avatarService;

    setUp(() {
      avatarService = AvatarService();
    });

    test('should not be speaking initially', () {
      expect(avatarService.isSpeaking, false);
    });

    test('should not be listening initially', () {
      expect(avatarService.isListening, false);
    });

    test('should have default status message', () {
      expect(avatarService.statusMessage, 'Připraven vám pomoci');
    });

    test('should update state when startSpeaking is called', () {
      avatarService.startSpeaking();
      expect(avatarService.isSpeaking, true);
      expect(avatarService.isListening, false);
      expect(avatarService.statusMessage, 'Odpovídám...');
    });

    test('should update state when stopSpeaking is called', () {
      avatarService.startSpeaking();
      avatarService.stopSpeaking();
      expect(avatarService.isSpeaking, false);
      expect(avatarService.statusMessage, 'Připraven vám pomoci');
    });

    test('should update state when startListening is called', () {
      avatarService.startListening();
      expect(avatarService.isListening, true);
      expect(avatarService.isSpeaking, false);
      expect(avatarService.statusMessage, 'Poslouchám váš dotaz...');
    });

    test('should update state when stopListening is called', () {
      avatarService.startListening();
      avatarService.stopListening();
      expect(avatarService.isListening, false);
      expect(avatarService.statusMessage, 'Připraven vám pomoci');
    });

    test('should set custom status message', () {
      avatarService.setStatus('Custom message');
      expect(avatarService.statusMessage, 'Custom message');
    });
  });
}
