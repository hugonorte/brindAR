import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:brindar/core/theme.dart';
import 'package:brindar/core/models/wine.dart';

class GlassOverlay extends StatelessWidget {
  final Wine wine;
  final VoidCallback onDetailsTap;

  const GlassOverlay({
    super.key,
    required this.wine,
    required this.onDetailsTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha((0.85 * 255).toInt()),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: Colors.white.withAlpha((0.2 * 255).toInt())),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      wine.score,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                  Text('Vintage ${wine.vintage}', style: const TextStyle(color: AppTheme.secondary, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                wine.name,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 24),
              ),
              Text(
                '${wine.type} • ${wine.origin}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.primary),
              ),
              const SizedBox(height: 20),
              const Divider(color: Colors.black12),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStat(context, 'ABV', wine.abv),
                  _buildStat(context, 'Body', wine.body),
                  _buildStat(context, 'Temp', wine.temperature),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: onDetailsTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: const Text('Ver Detalhes do Sommelier', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: AppTheme.secondary, fontWeight: FontWeight.bold)),
        Text(value, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16)),
      ],
    );
  }
}
