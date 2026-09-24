import 'package:flutter/material.dart';
import '../main.dart'; // AppColors

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  int _selectedSplitIndex = 0;
  final List<String> _splitMethods = ['Equal', 'Exact', 'Percentage', 'Custom'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Expense'),
        backgroundColor: AppColors.background,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Save', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Amount Input
            Center(
              child: Column(
                children: [
                  const Text('Total Amount', style: TextStyle(color: AppColors.textSecondary)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('\$', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                      SizedBox(
                        width: 150,
                        child: TextField(
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: '0.00',
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            filled: false,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Expense Title
            const TextField(
              decoration: InputDecoration(
                labelText: 'Expense Title',
                hintText: 'e.g. Dinner, Groceries',
                prefixIcon: Icon(Icons.description_rounded),
              ),
            ),
            const SizedBox(height: 16),

            // Paid By
            DropdownButtonFormField<String>(
              initialValue: 'You',
              decoration: const InputDecoration(
                labelText: 'Paid By',
                prefixIcon: Icon(Icons.person_rounded),
              ),
              items: const [
                DropdownMenuItem(value: 'You', child: Text('You')),
                DropdownMenuItem(value: 'Alex', child: Text('Alex')),
                DropdownMenuItem(value: 'Sarah', child: Text('Sarah')),
              ],
              onChanged: (value) {},
            ),
            const SizedBox(height: 24),

            // Split Method
            Text('Split Method', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(_splitMethods.length, (index) {
                  final isSelected = _selectedSplitIndex == index;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(_splitMethods[index]),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() => _selectedSplitIndex = index);
                        }
                      },
                      selectedColor: AppColors.primary,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : AppColors.textPrimary,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      backgroundColor: AppColors.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: isSelected ? AppColors.primary : AppColors.border),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 24),

            // Split Between Preview (Equal)
            if (_selectedSplitIndex == 0) ...[
              Text('Split Between (4)', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),
              _buildSplitMemberRow('You', '\$0.00', true),
              _buildSplitMemberRow('Alex', '\$0.00', true),
              _buildSplitMemberRow('Sarah', '\$0.00', true),
              _buildSplitMemberRow('John', '\$0.00', true),
            ],
            
            const SizedBox(height: 32),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Notes (Optional)',
                prefixIcon: Icon(Icons.note_rounded),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Date',
                prefixIcon: Icon(Icons.calendar_today_rounded),
              ),
              readOnly: true, // Should open date picker
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSplitMemberRow(String name, String amount, bool isIncluded) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Checkbox(
            value: isIncluded,
            onChanged: (val) {},
            activeColor: AppColors.primary,
          ),
          CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.primaryLight,
            child: Text(name[0], style: const TextStyle(fontSize: 12, color: AppColors.primary)),
          ),
          const SizedBox(width: 12),
          Text(name, style: const TextStyle(fontSize: 16)),
          const Spacer(),
          Text(amount, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
