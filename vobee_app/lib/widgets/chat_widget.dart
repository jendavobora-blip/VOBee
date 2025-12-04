import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/chat_service.dart';
import '../services/avatar_service.dart';
import '../models/chat_message.dart';
import '../theme/app_theme.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({super.key});

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isListening = false;

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    final chatService = context.read<ChatService>();
    final avatarService = context.read<AvatarService>();

    chatService.sendMessage(text);
    _textController.clear();

    // Simulate avatar response
    avatarService.startSpeaking();
    Future.delayed(const Duration(seconds: 2), () {
      avatarService.stopSpeaking();
    });

    // Scroll to bottom after message is added
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  void _toggleVoiceInput() {
    final avatarService = context.read<AvatarService>();
    setState(() {
      _isListening = !_isListening;
    });

    if (_isListening) {
      avatarService.startListening();
      // Simulate voice recognition
      Future.delayed(const Duration(seconds: 3), () {
        if (_isListening) {
          setState(() {
            _isListening = false;
          });
          avatarService.stopListening();
          _textController.text = 'Jaký je můj aktuální rozpočet?';
        }
      });
    } else {
      avatarService.stopListening();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.chat, color: AppTheme.primaryGold),
                const SizedBox(width: 8),
                Text(
                  'Chat s asistentem',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Chat Messages
            Consumer<ChatService>(
              builder: (context, chatService, child) {
                return Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: AppTheme.darkBackground,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: chatService.messages.isEmpty
                      ? const Center(
                          child: Text(
                            'Zeptejte se na cokoliv o financích...',
                            style: TextStyle(color: AppTheme.textSecondary),
                          ),
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.all(12),
                          itemCount: chatService.messages.length,
                          itemBuilder: (context, index) {
                            final message = chatService.messages[index];
                            return _buildMessageBubble(message);
                          },
                        ),
                );
              },
            ),
            const SizedBox(height: 12),
            
            // Input Row
            Row(
              children: [
                // Voice Input Button
                Container(
                  decoration: BoxDecoration(
                    color: _isListening
                        ? AppTheme.error
                        : AppTheme.primaryGold.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      _isListening ? Icons.mic : Icons.mic_none,
                      color: _isListening ? Colors.white : AppTheme.primaryGold,
                    ),
                    onPressed: _toggleVoiceInput,
                    tooltip: 'Hlasový vstup',
                  ),
                ),
                const SizedBox(width: 12),
                
                // Text Input
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'Napište zprávu...',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 12),
                
                // Send Button
                Container(
                  decoration: const BoxDecoration(
                    color: AppTheme.primaryGold,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.send,
                      color: AppTheme.darkBackground,
                    ),
                    onPressed: _sendMessage,
                    tooltip: 'Odeslat',
                  ),
                ),
              ],
            ),
            
            // Quick Suggestions
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildSuggestionChip('Jak investovat?'),
                _buildSuggestionChip('Tipy na úspory'),
                _buildSuggestionChip('Vysvětli ETF'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    final isUser = message.isUser;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        decoration: BoxDecoration(
          color: isUser ? AppTheme.primaryGold : AppTheme.cardDark,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isUser ? 16 : 4),
            bottomRight: Radius.circular(isUser ? 4 : 16),
          ),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: isUser ? AppTheme.darkBackground : AppTheme.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestionChip(String text) {
    return ActionChip(
      label: Text(text),
      labelStyle: const TextStyle(color: AppTheme.primaryGold, fontSize: 12),
      backgroundColor: AppTheme.primaryGold.withValues(alpha: 0.1),
      side: BorderSide(color: AppTheme.primaryGold.withValues(alpha: 0.3)),
      onPressed: () {
        _textController.text = text;
        _sendMessage();
      },
    );
  }
}
