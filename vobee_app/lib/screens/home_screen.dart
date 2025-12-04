import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/chat_service.dart';
import '../services/avatar_service.dart';
import '../widgets/avatar_widget.dart';
import '../widgets/chat_widget.dart';
import '../widgets/feature_card.dart';
import '../theme/app_theme.dart';
import 'investments_screen.dart';
import 'crypto_screen.dart';
import 'budget_screen.dart';
import 'debt_screen.dart';
import 'education_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const _MainHomeContent(),
    const InvestmentsScreen(),
    const CryptoScreen(),
    const BudgetScreen(),
    const DebtScreen(),
    const EducationScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppTheme.primaryGold,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.savings,
                color: AppTheme.darkBackground,
                size: 24,
              ),
            ),
            const SizedBox(width: 8),
            const Text('VoBee'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              _showSettingsDialog(context);
            },
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Domů',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Investice',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_bitcoin),
            label: 'Krypto',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Rozpočet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card_off),
            label: 'Dluhy',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Vzdělání',
          ),
        ],
      ),
    );
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nastavení'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.language),
              title: Text('Jazyk'),
              subtitle: Text('Čeština'),
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notifikace'),
              subtitle: Text('Zapnuto'),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('O aplikaci'),
              subtitle: Text('VoBee v1.0.0'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Zavřít'),
          ),
        ],
      ),
    );
  }
}

class _MainHomeContent extends StatelessWidget {
  const _MainHomeContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Avatar Section
            const AvatarWidget(),
            const SizedBox(height: 24),
            
            // Chat Section
            const ChatWidget(),
            const SizedBox(height: 24),
            
            // Quick Features Grid
            Text(
              'Finanční přehled',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.5,
              children: const [
                FeatureCard(
                  icon: Icons.trending_up,
                  title: 'Investice',
                  value: '125 000 Kč',
                  change: '+5.2%',
                  isPositive: true,
                ),
                FeatureCard(
                  icon: Icons.currency_bitcoin,
                  title: 'Kryptoměny',
                  value: '45 000 Kč',
                  change: '-2.1%',
                  isPositive: false,
                ),
                FeatureCard(
                  icon: Icons.account_balance_wallet,
                  title: 'Úspory',
                  value: '80 000 Kč',
                  change: '+1.5%',
                  isPositive: true,
                ),
                FeatureCard(
                  icon: Icons.credit_card_off,
                  title: 'Dluhy',
                  value: '15 000 Kč',
                  change: '-10%',
                  isPositive: true,
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Tips Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.lightbulb,
                          color: AppTheme.primaryGold,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Tip dne',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Pravidlo 50/30/20: Rozdělte své příjmy na 50% potřeby, 30% přání a 20% úspory. Toto jednoduché pravidlo vám pomůže udržet zdravý finanční rozpočet.',
                      style: TextStyle(color: AppTheme.textSecondary),
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
