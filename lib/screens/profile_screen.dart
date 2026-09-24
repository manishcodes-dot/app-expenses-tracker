import 'package:flutter/material.dart';
import '../main.dart'; // AppColors

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 120.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            const CircleAvatar(
              radius: 48,
              backgroundColor: AppColors.primary,
              child: Text('A', style: TextStyle(fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 16),
            const Text('Alex Johnson', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
            const SizedBox(height: 4),
            const Text('alex@example.com', style: TextStyle(color: AppColors.textSecondary)),
            const SizedBox(height: 32),

            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStat('Groups', '4'),
                    Container(width: 1, height: 40, color: AppColors.border),
                    _buildStat('Expenses', '28'),
                    Container(width: 1, height: 40, color: AppColors.border),
                    _buildStat('Settled', '\$450'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            Align(
              alignment: Alignment.centerLeft,
              child: Text('Settings', style: Theme.of(context).textTheme.titleLarge),
            ),
            const SizedBox(height: 16),
            Card(
              margin: EdgeInsets.zero,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.dark_mode_rounded),
                    title: const Text('Dark Mode'),
                    trailing: Switch(
                      value: false,
                      onChanged: (val) {},
                      activeThumbColor: AppColors.primary,
                    ),
                  ),
                  const Divider(height: 1, indent: 56),
                  ListTile(
                    leading: const Icon(Icons.notifications_rounded),
                    title: const Text('Notifications'),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () {},
                  ),
                  const Divider(height: 1, indent: 56),
                  ListTile(
                    leading: const Icon(Icons.account_balance_wallet_rounded),
                    title: const Text('Payment Methods'),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () {},
                  ),
                  const Divider(height: 1, indent: 56),
                  ListTile(
                    leading: const Icon(Icons.info_rounded),
                    title: const Text('About SplitEase'),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            TextButton(
              onPressed: () {},
              child: const Text('Log Out', style: TextStyle(color: AppColors.danger, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
      ],
    );
  }
}
