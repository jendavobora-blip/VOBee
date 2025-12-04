import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class DebtScreen extends StatelessWidget {
  const DebtScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Správa dluhů',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Přehled a plán splácení dluhů',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          
          // Total Debt Overview
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Celkový dluh',
                    style: TextStyle(color: AppTheme.textSecondary),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '15 000 Kč',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 4),
                  const Row(
                    children: [
                      Icon(Icons.arrow_downward, color: AppTheme.success, size: 16),
                      SizedBox(width: 4),
                      Text(
                        '-10% oproti minulému měsíci',
                        style: TextStyle(color: AppTheme.success),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Měsíční splátky:', style: TextStyle(color: AppTheme.textSecondary)),
                      Text('2 500 Kč', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Odhadovaný konec splácení:', style: TextStyle(color: AppTheme.textSecondary)),
                      Text('Červen 2025', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // Debt Items
          Text(
            'Aktivní dluhy',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          
          _buildDebtItem(
            context,
            'Spotřebitelský úvěr',
            10000,
            15000,
            800,
            5.9,
            Icons.credit_card,
          ),
          _buildDebtItem(
            context,
            'Nákup na splátky',
            5000,
            8000,
            500,
            0.0,
            Icons.shopping_bag,
          ),
          
          const SizedBox(height: 24),
          
          // Debt Strategy Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.lightbulb, color: AppTheme.primaryGold),
                      const SizedBox(width: 8),
                      Text(
                        'Strategie splácení',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Doporučujeme metodu "lavina" - splatit nejdříve dluhy s nejvyšším úrokem.',
                    style: TextStyle(color: AppTheme.textSecondary),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: [
                      Chip(
                        label: const Text('Lavina'),
                        backgroundColor: AppTheme.primaryGold.withValues(alpha: 0.2),
                        labelStyle: const TextStyle(color: AppTheme.primaryGold),
                      ),
                      Chip(
                        label: const Text('Sněhová koule'),
                        backgroundColor: AppTheme.surfaceDark,
                        labelStyle: const TextStyle(color: AppTheme.textSecondary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Přidat dluh'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDebtItem(
    BuildContext context,
    String name,
    double remaining,
    double original,
    double monthlyPayment,
    double interestRate,
    IconData icon,
  ) {
    final progress = 1 - (remaining / original);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.error.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: AppTheme.error),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        interestRate > 0 ? 'Úrok: $interestRate%' : 'Bez úroku',
                        style: const TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${remaining.toInt()} Kč',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Splátka: ${monthlyPayment.toInt()} Kč/měs',
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: AppTheme.surfaceDark,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.success),
                      minHeight: 8,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${(progress * 100).toInt()}% splaceno',
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
