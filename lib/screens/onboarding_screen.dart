import 'package:flutter/material.dart';
import '../main.dart'; // AppColors

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(Icons.calculate_rounded, size: 64, color: AppColors.primary),
            ),
            const SizedBox(height: 24),
            const Text(
              'SplitEase',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const Icon(Icons.group_add_rounded, size: 120, color: AppColors.primary),
              const SizedBox(height: 48),
              const Text(
                'Simple group expense splitting.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 16),
              const Text(
                'Without the awkward math. Create groups, add expenses, and instantly know who owes whom.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 24, height: 8, decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(4))),
                  const SizedBox(width: 8),
                  Container(width: 8, height: 8, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(4))),
                  const SizedBox(width: 8),
                  Container(width: 8, height: 8, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(4))),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Get Started'),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {},
                child: const Text('Log In', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
