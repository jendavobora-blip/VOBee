import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'services/chat_service.dart';
import 'services/avatar_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const VoBeeApp());
}

class VoBeeApp extends StatelessWidget {
  const VoBeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatService()),
        ChangeNotifierProvider(create: (_) => AvatarService()),
      ],
      child: MaterialApp(
        title: 'VoBee',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
