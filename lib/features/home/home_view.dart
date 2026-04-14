import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:brindar/core/theme.dart';
import 'package:brindar/core/providers/wine_provider.dart';
import 'package:brindar/core/models/wine.dart';
import 'package:brindar/shared/widgets/brindar_card.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WineProvider>().fetchInitialData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 32),
              _buildKnowledgeBase(),
              const SizedBox(height: 40),
              _buildPairingSuggestions(),
              const SizedBox(height: 40),
              _buildWineRanking(),
              const SizedBox(height: 40),
              _buildVideoRanking(),
              const SizedBox(height: 100), // Spacing for bottom bar
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
      extendBody: true,
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bem-vindo de volta',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 4),
        Text(
          'Boa noite, Hugo!!',
          style: Theme.of(context).textTheme.headlineMedium, // ~28px
        ),
      ],
    ).animate().fadeIn().slideX(begin: -0.1);
  }

  Widget _buildKnowledgeBase() {
    return BrindarCard(
      useTonalShift: true,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                LucideIcons.bookOpen,
                color: AppTheme.primary,
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(
                'Base de Conhecimento',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Aqui você tirará todas as suas dúvidas sobre vinho',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms).scale(begin: const Offset(0.95, 0.95));
  }

  Widget _buildPairingSuggestions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sugestões de Harmonização',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildPairingCard(
                'Carnes Vermelhas',
                'Cabernet Sauvignon',
                LucideIcons.beef,
              ),
              _buildPairingCard(
                'Queijos Maturados',
                'Merlot ou Syrah',
                LucideIcons.utensils,
              ),
              _buildPairingCard(
                'Frutos do Mar',
                'Sauvignon Blanc',
                LucideIcons.fish,
              ),
            ],
          ),
        ),
      ],
    ).animate().fadeIn(delay: 400.ms);
  }

  Widget _buildPairingCard(String title, String wine, IconData icon) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 16),
      child: BrindarCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppTheme.primary, size: 28),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              wine,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppTheme.primary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWineRanking() {
    return Consumer<WineProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ranking de Vinhos',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            ...provider.ranking.map(
              (wine) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildRankingItem(wine),
              ),
            ),
          ],
        );
      },
    ).animate().fadeIn(delay: 600.ms);
  }

  Widget _buildVideoRanking() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Vídeos Mais Curtidos',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildVideoCard(
                'Dicas de Decantação',
                'Sommelier João',
                '1.2k likes',
              ),
              _buildVideoCard('Cabernet vs Merlot', 'Ana Vinhos', '850 likes'),
              _buildVideoCard('Temperatura Ideal', 'Vinho 101', '2.1k likes'),
            ],
          ),
        ),
      ],
    ).animate().fadeIn(delay: 800.ms);
  }

  Widget _buildVideoCard(String title, String author, String likes) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: AppTheme.onBackground.withAlpha((0.05 * 255).toInt()),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: AppTheme.primary.withAlpha((0.1 * 255).toInt()),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: const Center(
              child: Icon(LucideIcons.play, color: AppTheme.primary),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  author,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontSize: 10),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      LucideIcons.heart,
                      size: 10,
                      color: AppTheme.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      likes,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRankingItem(Wine wine) {
    return BrindarCard(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppTheme.primary.withAlpha((0.08 * 255).toInt()),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(LucideIcons.wine, color: AppTheme.primary, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  wine.name,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontSize: 18),
                ),
                Text(wine.type, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    wine.tag,
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge?.copyWith(color: AppTheme.primary),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              LucideIcons.chevronRight,
              color: AppTheme.secondary,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: AppTheme.primary,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withAlpha((0.3 * 255).toInt()),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(LucideIcons.layoutGrid, 'Dashboard', 0),
          _buildNavItem(LucideIcons.scan, 'Scan', 1),
          _buildNavItem(LucideIcons.book, 'Library', 2),
          _buildNavItem(LucideIcons.graduationCap, 'Education', 3),
        ],
      ),
    ).animate().slideY(begin: 1, duration: 800.ms, curve: Curves.easeOutBack);
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() => _selectedIndex = index);
        if (index == 1) {
          Navigator.pushNamed(
            context,
            '/scan',
          ).then((_) => setState(() => _selectedIndex = 0));
        } else if (index == 2) {
          Navigator.pushNamed(
            context,
            '/library',
          ).then((_) => setState(() => _selectedIndex = 0));
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.white : Colors.white54,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white54,
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
