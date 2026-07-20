import 'package:flutter/material.dart';
import '../main.dart'; // For AppColors temporarily

class GroupDetailsScreen extends StatelessWidget {
  const GroupDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Bali Trip 2026', style: TextStyle(color: AppColors.textPrimary)),
              background: Container(
                color: AppColors.primaryLight,
                child: Center(
                  child: Icon(Icons.flight_takeoff_rounded, size: 80, color: AppColors.primary.withOpacity(0.5)),
                ),
              ),
            ),
            actions: [
              IconButton(icon: const Icon(Icons.settings_rounded), onPressed: () {}),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Members Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Members', style: Theme.of(context).textTheme.titleMedium),
                      TextButton(onPressed: () {}, child: const Text('Add Member')),
                    ],
                  ),
                  Row(
                    children: [
                      _buildAvatar('A', AppColors.primary),
                      const SizedBox(width: 8),
                      _buildAvatar('B', AppColors.secondary),
                      const SizedBox(width: 8),
                      _buildAvatar('C', AppColors.warning),
                      const SizedBox(width: 8),
                      _buildAvatar('+', AppColors.border, isAdd: true),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Balance Summary
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.success.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.success.withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('You are owed', style: TextStyle(color: AppColors.success, fontWeight: FontWeight.w500)),
                            SizedBox(height: 4),
                            Text('\$120.00', style: TextStyle(color: AppColors.success, fontSize: 24, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.success,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          ),
                          child: const Text('Settle Up'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  Text('Expenses', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: const Icon(Icons.restaurant_rounded, color: AppColors.primary),
                  ),
                  title: const Text('Dinner at Jimbaran'),
                  subtitle: const Text('Alex paid • Today'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text('\$85.00', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('You owe \$21.25', style: TextStyle(fontSize: 12, color: AppColors.danger)),
                    ],
                  ),
                  onTap: () {},
                );
              },
              childCount: 5,
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 80)), // Padding for FAB
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add Expense'),
      ),
    );
  }

  Widget _buildAvatar(String label, Color color, {bool isAdd = false}) {
    return CircleAvatar(
      backgroundColor: color,
      child: isAdd 
          ? const Icon(Icons.add_rounded, color: AppColors.textSecondary)
          : Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }
}
