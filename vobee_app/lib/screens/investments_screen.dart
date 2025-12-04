import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class InvestmentsScreen extends StatelessWidget {
  const InvestmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Správa investic',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Přehled vašeho investičního portfolia',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          
          // Portfolio Summary Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Celková hodnota portfolia',
                    style: TextStyle(color: AppTheme.textSecondary),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '125 000 Kč',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 4),
                  const Row(
                    children: [
                      Icon(Icons.arrow_upward, color: AppTheme.success, size: 16),
                      SizedBox(width: 4),
                      Text(
                        '+5.2% tento měsíc',
                        style: TextStyle(color: AppTheme.success),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Investment Items
          _buildInvestmentItem(
            context,
            'Akcie ČEZ',
            '35 000 Kč',
            '+3.5%',
            true,
            Icons.electric_bolt,
          ),
          _buildInvestmentItem(
            context,
            'ETF S&P 500',
            '50 000 Kč',
            '+7.2%',
            true,
            Icons.public,
          ),
          _buildInvestmentItem(
            context,
            'Dluhopisy',
            '25 000 Kč',
            '+2.1%',
            true,
            Icons.account_balance,
          ),
          _buildInvestmentItem(
            context,
            'Zlato',
            '15 000 Kč',
            '-1.2%',
            false,
            Icons.diamond,
          ),
          
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                _showAddInvestmentDialog(context);
              },
              icon: const Icon(Icons.add),
              label: const Text('Přidat investici'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvestmentItem(
    BuildContext context,
    String name,
    String value,
    String change,
    bool isPositive,
    IconData icon,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primaryGold.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppTheme.primaryGold),
        ),
        title: Text(name),
        subtitle: Text(value),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: (isPositive ? AppTheme.success : AppTheme.error).withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            change,
            style: TextStyle(
              color: isPositive ? AppTheme.success : AppTheme.error,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void _showAddInvestmentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Přidat investici'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Název investice',
                hintText: 'např. Akcie Tesla',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Hodnota (Kč)',
                hintText: '10000',
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Zrušit'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Přidat'),
          ),
        ],
      ),
    );
  }
}
