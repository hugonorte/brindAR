import 'package:flutter/material.dart';
import 'package:brindar/core/theme.dart';

class BrindarCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final bool useTonalShift;

  const BrindarCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.useTonalShift = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: useTonalShift ? AppTheme.surfaceContainerLow : AppTheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: useTonalShift
            ? null
            : [
                BoxShadow(
                  color: AppTheme.onBackground.withAlpha((0.04 * 255).toInt()),
                  blurRadius: 32,
                  offset: const Offset(0, 8),
                ),
              ],
      ),
      child: child,
    );
  }
}
