import 'package:flutter/material.dart';
import '../main.dart'; // For AppColors

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const AnimatedSearchBar(
          hintText: 'Search groups...',
          defaultTitle: Text('Your Groups', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 100), // padding for floating nav bar
        itemCount: 4,
        itemBuilder: (context, index) {
          return AnimatedListItem(
            index: index,
            child: _buildGroupCard(context, index),
          );
        },
      ),
    );
  }

  Widget _buildGroupCard(BuildContext context, int index) {
    // Dummy data
    final titles = ['Bali Trip 2026', 'Roommates', 'Dinner at Jimbaran', 'Weekend Getaway'];
    final memberCounts = [4, 3, 5, 2];
    final amounts = ['\$120.00', '\$45.00', '\$0.00', '\$85.50'];
    final isOwedList = [true, false, null, true];
    final icons = [Icons.flight_takeoff_rounded, Icons.home_rounded, Icons.restaurant_rounded, Icons.directions_car_rounded];
    final colors = [AppColors.primary, AppColors.secondary, AppColors.warning, AppColors.primary];

    final isOwed = isOwedList[index];

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          // Navigate to group details
        },
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Group Icon
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: colors[index].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icons[index], color: colors[index], size: 28),
              ),
              const SizedBox(width: 16),
              
              // Group Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(titles[index], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                    const SizedBox(height: 4),
                    Text('${memberCounts[index]} members', style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                  ],
                ),
              ),

              // Balance Info
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (isOwed == null) ...[
                    const Text('Settled up', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                    const Icon(Icons.check_circle_rounded, color: AppColors.textSecondary, size: 16),
                  ] else if (isOwed) ...[
                    const Text('You are owed', style: TextStyle(fontSize: 13, color: AppColors.success)),
                    Text(amounts[index], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.success)),
                  ] else ...[
                    const Text('You owe', style: TextStyle(fontSize: 13, color: AppColors.danger)),
                    Text(amounts[index], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.danger)),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
