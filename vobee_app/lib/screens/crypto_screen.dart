import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CryptoScreen extends StatelessWidget {
  const CryptoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kryptoměny',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Přehled vašich kryptoaktiv',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          
          // Portfolio Summary
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Celková hodnota krypta',
                    style: TextStyle(color: AppTheme.textSecondary),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '45 000 Kč',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 4),
                  const Row(
                    children: [
                      Icon(Icons.arrow_downward, color: AppTheme.error, size: 16),
                      SizedBox(width: 4),
                      Text(
                        '-2.1% tento týden',
                        style: TextStyle(color: AppTheme.error),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Crypto Items
          _buildCryptoItem(context, 'Bitcoin', 'BTC', '25 000 Kč', '0.012 BTC', '+1.5%', true),
          _buildCryptoItem(context, 'Ethereum', 'ETH', '12 000 Kč', '0.15 ETH', '-3.2%', false),
          _buildCryptoItem(context, 'Cardano', 'ADA', '5 000 Kč', '2500 ADA', '-5.1%', false),
          _buildCryptoItem(context, 'Solana', 'SOL', '3 000 Kč', '30 SOL', '+2.3%', true),
          
          const SizedBox(height: 24),
          
          // Warning Card
          Card(
            color: AppTheme.warning.withValues(alpha: 0.1),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.warning_amber, color: AppTheme.warning),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Upozornění',
                          style: TextStyle(
                            color: AppTheme.warning,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Kryptoměny jsou velmi volatilní. Investujte pouze prostředky, které si můžete dovolit ztratit.',
                          style: TextStyle(color: AppTheme.textSecondary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCryptoItem(
    BuildContext context,
    String name,
    String symbol,
    String valueCzk,
    String amount,
    String change,
    bool isPositive,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppTheme.primaryGold.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Center(
            child: Text(
              symbol.substring(0, 1),
              style: const TextStyle(
                color: AppTheme.primaryGold,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        title: Text(name),
        subtitle: Text('$amount • $symbol'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              valueCzk,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              change,
              style: TextStyle(
                color: isPositive ? AppTheme.success : AppTheme.error,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
