import 'package:flutter/material.dart';
import '../main.dart'; // For AppColors

class ScannerScreen extends StatefulWidget {
  final bool initialScanMode;
  const ScannerScreen({super.key, this.initialScanMode = true});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  late bool _isScanMode;
  int _selectedSplitIndex = 0;
  final List<String> _splitMethods = ['Equal', 'Exact', 'Percentage', 'Custom'];

  @override
  void initState() {
    super.initState();
    _isScanMode = widget.initialScanMode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isScanMode ? Colors.black : AppColors.background,
      appBar: AppBar(
        backgroundColor: _isScanMode ? Colors.transparent : AppColors.background,
        elevation: 0,
        iconTheme: IconThemeData(color: _isScanMode ? Colors.white : AppColors.textPrimary),
        title: Text(
          _isScanMode ? 'Scan Receipt' : 'Add Expense',
          style: TextStyle(
            color: _isScanMode ? Colors.white : AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: _isScanMode
            ? [
                IconButton(
                  icon: const Icon(Icons.flash_off_rounded),
                  onPressed: () {},
                ),
              ]
            : [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primary),
                  ),
                ),
              ],
      ),
      extendBodyBehindAppBar: _isScanMode,
      body: Stack(
        children: [
          // Main Content View (Scan vs Manual Form)
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _isScanMode ? _buildScannerBody() : _buildManualFormBody(),
          ),

          // Bottom Controls Container (Shutter Button + Mode Switcher Pill)
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Camera Shutter Button (only active in Scan Mode)
                  if (_isScanMode) ...[
                    Material(
                      color: AppColors.primary,
                      elevation: 8,
                      shape: const CircleBorder(
                        side: BorderSide(color: Colors.white, width: 4),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const SizedBox(
                          width: 64,
                          height: 64,
                          child: Icon(Icons.camera_alt_rounded, color: Colors.white, size: 28),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Mode Switcher Pill ("Scan" | "Manually")
                  _buildModeTogglePill(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScannerBody() {
    return Stack(
      key: const ValueKey('ScannerView'),
      alignment: Alignment.center,
      children: [
        // Camera View Simulation
        Container(
          color: Colors.black87,
          width: double.infinity,
          height: double.infinity,
        ),

        // Scanner Frame
        Container(
          width: 280,
          height: 380,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primary, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
        ),

        // Instructions
        const Positioned(
          bottom: 180,
          child: Text(
            'Align receipt within frame',
            style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Widget _buildManualFormBody() {
    return SingleChildScrollView(
      key: const ValueKey('ManualFormView'),
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 100.0),
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
                        decoration: const InputDecoration(
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
          const SizedBox(height: 24),

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

          // Split Between Preview
          if (_selectedSplitIndex == 0) ...[
            Text('Split Between (4)', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            _buildSplitMemberRow('You', '\$0.00', true),
            _buildSplitMemberRow('Alex', '\$0.00', true),
            _buildSplitMemberRow('Sarah', '\$0.00', true),
            _buildSplitMemberRow('John', '\$0.00', true),
          ],

          const SizedBox(height: 24),
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
            readOnly: true,
          ),
        ],
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

  Widget _buildModeTogglePill() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: _isScanMode ? Colors.black.withValues(alpha: 0.7) : AppColors.surface,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: _isScanMode ? Colors.white30 : AppColors.border,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Scan Option
          GestureDetector(
            onTap: () {
              if (!_isScanMode) {
                setState(() => _isScanMode = true);
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: _isScanMode ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.qr_code_scanner_rounded,
                    size: 18,
                    color: _isScanMode ? Colors.white : AppColors.textSecondary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Scan',
                    style: TextStyle(
                      color: _isScanMode ? Colors.white : AppColors.textSecondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Manually Option
          GestureDetector(
            onTap: () {
              if (_isScanMode) {
                setState(() => _isScanMode = false);
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: !_isScanMode ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.edit_note_rounded,
                    size: 18,
                    color: !_isScanMode ? Colors.white : Colors.white70,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Manually',
                    style: TextStyle(
                      color: !_isScanMode ? Colors.white : Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

