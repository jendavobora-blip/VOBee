import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Finanční vzdělání',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Kurzy a materiály pro finanční gramotnost',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          
          // Progress Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.emoji_events, color: AppTheme.primaryGold),
                      const SizedBox(width: 8),
                      Text(
                        'Váš pokrok',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildProgressStat('3', 'Dokončené kurzy'),
                      _buildProgressStat('12', 'Odznaky'),
                      _buildProgressStat('850', 'Body'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // Courses
          Text(
            'Doporučené kurzy',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          
          _buildCourseCard(
            context,
            'Základy investování',
            'Naučte se základy investování do akcií a ETF',
            Icons.trending_up,
            0.3,
            '30 min',
            'Začátečník',
          ),
          _buildCourseCard(
            context,
            'Jak na rozpočet',
            'Vytvořte si efektivní měsíční rozpočet',
            Icons.account_balance_wallet,
            1.0,
            '20 min',
            'Začátečník',
          ),
          _buildCourseCard(
            context,
            'Kryptoměny 101',
            'Úvod do světa kryptoměn a blockchainu',
            Icons.currency_bitcoin,
            0.0,
            '45 min',
            'Středně pokročilý',
          ),
          _buildCourseCard(
            context,
            'Daňové tipy',
            'Jak optimalizovat daně z investic',
            Icons.receipt_long,
            0.0,
            '25 min',
            'Pokročilý',
          ),
          
          const SizedBox(height: 24),
          
          // Quick Tips
          Text(
            'Rychlé tipy',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          
          _buildTipCard(
            context,
            'Nouzový fond',
            'Mějte vždy úspory na 3-6 měsíců výdajů jako rezervu.',
            Icons.savings,
          ),
          _buildTipCard(
            context,
            'Složený úrok',
            'Čas je váš nejlepší přítel při investování. Začněte co nejdříve!',
            Icons.show_chart,
          ),
          _buildTipCard(
            context,
            'Diverzifikace',
            'Nevsázejte vše na jednu kartu. Rozložte své investice.',
            Icons.pie_chart,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: AppTheme.primaryGold,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildCourseCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    double progress,
    String duration,
    String level,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGold.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: AppTheme.primaryGold),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.timer, size: 12, color: AppTheme.textSecondary),
                            const SizedBox(width: 4),
                            Text(
                              duration,
                              style: const TextStyle(
                                color: AppTheme.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Icon(Icons.signal_cellular_alt, size: 12, color: AppTheme.textSecondary),
                            const SizedBox(width: 4),
                            Text(
                              level,
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
                  if (progress == 1.0)
                    const Icon(Icons.check_circle, color: AppTheme.success)
                  else if (progress > 0)
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: progress,
                            backgroundColor: AppTheme.surfaceDark,
                            valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryGold),
                            strokeWidth: 3,
                          ),
                          Text(
                            '${(progress * 100).toInt()}%',
                            style: const TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    )
                  else
                    const Icon(Icons.play_circle_outline, color: AppTheme.primaryGold),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTipCard(BuildContext context, String title, String tip, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: AppTheme.primaryGold),
        title: Text(title),
        subtitle: Text(
          tip,
          style: const TextStyle(color: AppTheme.textSecondary),
        ),
      ),
    );
  }
}
