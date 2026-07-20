import 'package:flutter/material.dart';
import '../main.dart'; // For AppColors

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const AnimatedSearchBar(
          hintText: 'Search activity...',
          defaultTitle: Text('Recent Activity', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _buildGraph(context),
          ),
          const SliverPadding(
            padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Recent Transactions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 120),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final bool isPayment = index % 3 == 0;
                  final bool isYou = index % 2 == 0;
                  return AnimatedListItem(
                    index: index,
                    child: Column(
                      children: [
                        _buildActivityItem(isPayment, isYou, index),
                        if (index < 14) const Divider(height: 1, indent: 72),
                      ],
                    ),
                  );
                },
                childCount: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGraph(BuildContext context) {
    // Dummy data for weekly expenses
    final List<Map<String, dynamic>> weeklyData = [
      {'day': 'Mon', 'amount': 0.4}, // 0.0 to 1.0 represents height percentage
      {'day': 'Tue', 'amount': 0.7},
      {'day': 'Wed', 'amount': 0.2},
      {'day': 'Thu', 'amount': 1.0},
      {'day': 'Fri', 'amount': 0.5},
      {'day': 'Sat', 'amount': 0.8},
      {'day': 'Sun', 'amount': 0.3},
    ];

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('This Week', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
            const SizedBox(height: 4),
            const Text('\$342.50', style: TextStyle(color: AppColors.textPrimary, fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: weeklyData.map((data) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 32,
                      height: 120 * (data['amount'] as double), // Max height is 120
                      decoration: BoxDecoration(
                        color: data['day'] == 'Thu' ? AppColors.primary : AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      data['day'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: data['day'] == 'Thu' ? FontWeight.bold : FontWeight.w500,
                        color: data['day'] == 'Thu' ? AppColors.primary : AppColors.textSecondary,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(bool isPayment, bool isYou, int index) {
    String title = '';
    String subtitle = '';
    String amount = '';
    IconData icon;
    Color iconBgColor;
    Color iconColor;

    if (isPayment) {
      icon = Icons.payments_rounded;
      iconColor = AppColors.success;
      iconBgColor = AppColors.success.withOpacity(0.1);
      if (isYou) {
        title = 'You paid Alex';
        subtitle = 'Bali Trip 2026 • Yesterday';
        amount = '\$25.00';
      } else {
        title = 'Sarah paid you';
        subtitle = 'Roommates • 2 days ago';
        amount = '\$12.50';
      }
    } else {
      icon = Icons.receipt_long_rounded;
      iconColor = AppColors.primary;
      iconBgColor = AppColors.primaryLight;
      if (isYou) {
        title = 'You added "Dinner at Jimbaran"';
        subtitle = 'Bali Trip 2026 • Yesterday';
        amount = '\$85.00';
      } else {
        title = 'Alex added "Groceries"';
        subtitle = 'Roommates • 3 days ago';
        amount = '\$45.20';
      }
    }

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: iconBgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Text(subtitle, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
      ),
      trailing: Text(
        amount,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: isPayment ? AppColors.success : AppColors.textPrimary,
        ),
      ),
      onTap: () {},
    );
  }
}
