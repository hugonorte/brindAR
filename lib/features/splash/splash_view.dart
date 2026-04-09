import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:brindar/core/theme.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: AppTheme.burgundyGradient,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 180,
              height: 180,
            ).animate().fade(duration: 1.seconds).scale(delay: 200.ms),
            const SizedBox(height: 24),
            Text(
              'BRINDAR',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Colors.white,
                    letterSpacing: 8,
                    fontSize: 36,
                  ),
            ).animate().fade(delay: 500.ms, duration: 1.seconds).slideY(begin: 0.5),
            const SizedBox(height: 8),
            Text(
              'PREMIUM WINE APP',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.white70,
                    letterSpacing: 4,
                  ),
            ).animate().fade(delay: 1.seconds, duration: 1.seconds),
          ],
        ),
      ),
    );
  }
}
