import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:brindar/core/theme.dart';
import 'package:brindar/core/providers/wine_provider.dart';
import 'package:brindar/core/models/wine.dart';
import 'package:brindar/shared/widgets/brindar_card.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LibraryView extends StatelessWidget {
  const LibraryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Minha Biblioteca',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(LucideIcons.search)),
          const SizedBox(width: 8),
        ],
      ),
      body: Consumer<WineProvider>(
        builder: (context, provider, child) {
          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              _buildCategoryHeader('Vinhos Escaneados'),
              const SizedBox(height: 16),
              if (provider.library.isEmpty)
                const Center(child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text('Nenhum vinho salvo ainda.'),
                ))
              else
                ...provider.library.map((wine) => _buildWineItem(context, wine)),
              const SizedBox(height: 32),
              _buildCategoryHeader('Dicas de Harmonização'),
              const SizedBox(height: 16),
              _buildArticleItem(context, 'Entendendo Taninos', '5 min de leitura'),
              _buildArticleItem(context, 'Regiões de Portugal', '8 min de leitura'),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCategoryHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
        color: AppTheme.secondary,
      ),
    );
  }

  Widget _buildWineItem(BuildContext context, Wine wine) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: BrindarCard(
        useTonalShift: true,
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(LucideIcons.wine, color: AppTheme.primary),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(wine.name, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16)),
                  Text('${wine.type} • ${wine.origin}', style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
            const Icon(LucideIcons.chevronRight, size: 16, color: AppTheme.secondary),
          ],
        ),
      ),
    ).animate().fadeIn().slideX(begin: 0.1);
  }

  Widget _buildArticleItem(BuildContext context, String title, String time) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: BrindarCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(LucideIcons.fileText, color: AppTheme.secondary),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16)),
                  Text(time, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideX(begin: 0.1);
  }
}
