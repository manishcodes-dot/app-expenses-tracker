import 'package:flutter/material.dart';
import '../main.dart'; // AppColors

class SettlementScreen extends StatelessWidget {
  const SettlementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settlement'),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Settlement Header
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildAvatar('Y', 'You', AppColors.primary),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Icon(Icons.arrow_forward_rounded, color: AppColors.textSecondary, size: 32),
                ),
                _buildAvatar('A', 'Alex', AppColors.secondary),
              ],
            ),
            const SizedBox(height: 24),
            const Text('You owe Alex', style: TextStyle(fontSize: 18, color: AppColors.textSecondary)),
            const SizedBox(height: 8),
            const Text('\$12.50', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
            
            const SizedBox(height: 48),

            // Settlement Options
            Card(
              margin: EdgeInsets.zero,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.check_circle_outline_rounded, color: AppColors.success),
                    title: const Text('Mark as Paid'),
                    subtitle: const Text('Record a cash or external payment'),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () {},
                  ),
                  const Divider(height: 1, indent: 56),
                  ListTile(
                    leading: const Icon(Icons.history_rounded, color: AppColors.primary),
                    title: const Text('Payment History'),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Expense Breakdown
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Included Expenses', style: Theme.of(context).textTheme.titleLarge),
            ),
            const SizedBox(height: 16),
            Card(
              margin: EdgeInsets.zero,
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 2,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(index == 0 ? 'Taxi from Airport' : 'Lunch at Cafe'),
                    subtitle: Text(index == 0 ? 'Yesterday' : '2 days ago'),
                    trailing: Text(index == 0 ? '\$8.50' : '\$4.00', style: const TextStyle(fontWeight: FontWeight.bold)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(String letter, String name, Color color) {
    return Column(
      children: [
        CircleAvatar(
          radius: 32,
          backgroundColor: color.withOpacity(0.2),
          child: Text(
            letter,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
          ),
        ),
        const SizedBox(height: 8),
        Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }
}
