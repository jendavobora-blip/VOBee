import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rozpočet',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Správa měsíčního rozpočtu',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          
          // Monthly Overview
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Měsíční přehled - Prosinec 2024',
                    style: TextStyle(color: AppTheme.textSecondary),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildBudgetStat(context, 'Příjmy', '65 000 Kč', AppTheme.success),
                      _buildBudgetStat(context, 'Výdaje', '48 000 Kč', AppTheme.error),
                      _buildBudgetStat(context, 'Úspory', '17 000 Kč', AppTheme.primaryGold),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // Budget Categories
          Text(
            'Kategorie výdajů',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          
          _buildCategoryProgress('Bydlení', 18000, 20000, Icons.home),
          _buildCategoryProgress('Jídlo', 8500, 10000, Icons.restaurant),
          _buildCategoryProgress('Doprava', 4200, 5000, Icons.directions_car),
          _buildCategoryProgress('Zábava', 5800, 5000, Icons.movie),
          _buildCategoryProgress('Ostatní', 3500, 8000, Icons.more_horiz),
          
          const SizedBox(height: 24),
          
          // 50/30/20 Rule Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.pie_chart, color: AppTheme.primaryGold),
                      const SizedBox(width: 8),
                      Text(
                        'Pravidlo 50/30/20',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildRuleRow('Potřeby (50%)', '32 500 Kč', 26700, 32500),
                  const SizedBox(height: 8),
                  _buildRuleRow('Přání (30%)', '19 500 Kč', 14800, 19500),
                  const SizedBox(height: 8),
                  _buildRuleRow('Úspory (20%)', '13 000 Kč', 17000, 13000),
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
              label: const Text('Přidat transakci'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetStat(BuildContext context, String label, String value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryProgress(String name, double spent, double budget, IconData icon) {
    final percentage = (spent / budget).clamp(0.0, 1.0);
    final isOverBudget = spent > budget;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppTheme.primaryGold, size: 20),
                const SizedBox(width: 8),
                Expanded(child: Text(name)),
                Text(
                  '${spent.toInt()} / ${budget.toInt()} Kč',
                  style: TextStyle(
                    color: isOverBudget ? AppTheme.error : AppTheme.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: percentage,
                backgroundColor: AppTheme.surfaceDark,
                valueColor: AlwaysStoppedAnimation<Color>(
                  isOverBudget ? AppTheme.error : AppTheme.primaryGold,
                ),
                minHeight: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRuleRow(String label, String target, double actual, double goal) {
    final percentage = (actual / goal).clamp(0.0, 1.5);
    final isOnTrack = actual <= goal * 1.1;
    
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 12)),
              Text(target, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 11)),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: AppTheme.surfaceDark,
              valueColor: AlwaysStoppedAnimation<Color>(
                isOnTrack ? AppTheme.success : AppTheme.warning,
              ),
              minHeight: 8,
            ),
          ),
        ),
      ],
    );
  }
}
