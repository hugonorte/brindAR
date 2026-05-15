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
    return Container(
      height: 240,
      width: double.infinity,
      child: BrindarCard(
        useTonalShift: false,
        padding: EdgeInsets.zero,
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.network(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuCYLrtSDJF-3XOatDco62Dj8PeEpoxwRtBSCpDgZ7_9RnIP3iCBA3SG_MHf26AdskC143C58IvVbYfX4x__MRmEl2GIIur7XwkDX8Mmw01qxsz-InbNvA5YxJUfYcx8JrUkrN2SUO-1XBe_I8tc62OC13F0Xj32z7FBvcF_d5DDSgp_nImFQrh6uBTjLaev1Ft6Mi-WhGl1cr0gZj337tBLOLLIuUppNW0qBcNRxfyYcdkcWftd2NQ7STMeXVKVs4ZajSPdpVU-Kik',
                  fit: BoxFit.cover,
                  color: Colors.black.withAlpha((0.3 * 255).toInt()),
                  colorBlendMode: BlendMode.darken,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      const Icon(
                        LucideIcons.bookOpen,
                        color: Colors.white,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Base de Conhecimento',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Aqui você tirará todas as suas dúvidas sobre vinho',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
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
                'https://lh3.googleusercontent.com/aida-public/AB6AXuCPl8-yizDWbzD_6GpxRkGoS1dnLEGtL14dgzFsOyv31yRchQNAVbXj3cniH2ZcKEquCbaoh2QTU_8nsHixm9HNozE2E9yBaChY67AycbyQ18xzJzB2zqdNWkZjutQgYR0XlPmKZA0tp548UXglRJkoB2DxwmTH_vR49U69CpfaVxV7oBMq1cD6YPFxkP9ZTqgEIxwaTyyVWC16I0CmJ3pww1zAcbH3We4SKInE4gKybTfkO0vOHXYQySDlURqUC3utfzWccS_rLMY',
              ),
              _buildPairingCard(
                'Queijos Maturados',
                'Merlot ou Syrah',
                'https://lh3.googleusercontent.com/aida-public/AB6AXuDkdOvHYUwy2dIaFxLrGLQEnFiOB6mbKS3yk3fCDxxEY868_nkxkEgp1WpXi8zs0WxC3G5wAYSO72eby-KDCcXgglaYU_jI6xeTHcUiKnnvrsOsrnZoT5Icbzxj-6jCd6O0ivgnTD3unUgo3JCHg0QP0rXY4evORsg6nONCZt9R6B6NUVITTUzvX0sF9MouQE0Y2frtn6zFCiv7jb0ovQuevPylmgvcmntv1YnFAC29COiNFLtNd5s5Zw2_B8-SML_6RCSA0Sd6QwU',
              ),
              _buildPairingCard(
                'Frutos do Mar',
                'Sauvignon Blanc',
                'https://lh3.googleusercontent.com/aida-public/AB6AXuAtMD-0Mg1vbcmbLJSFgLTxlL8Az6PMbmJJGsND3e1sQIsmiBnvxw1UlxQVN85TIyCXUQ90Xqd_vdLLtE5CIgPEnuk9iymYEwCproaT-g3dbgMdLInBB-VJnseRQYoKBrFb3Fe3HGJWlPJVfunxhzDIpbLPy9gYVxH4QA1OPcyiM7c4Nl8COD1a1YjIfj1LCe7up0oRJS0yuN4G3S80kd9bmgBgS_rylMgq37S1AdedlzOpY8N3p0Hp4jmI4JwTSA9cP2eC1FqOfcM',
              ),
            ],
          ),
        ),
      ],
    ).animate().fadeIn(delay: 400.ms);
  }

  Widget _buildPairingCard(String title, String wine, String imageUrl) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 16),
      child: BrindarCard(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                imageUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
        final orderedRanking = _orderedWineRanking(provider.ranking);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ranking de Vinhos',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            ...orderedRanking.asMap().entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildRankingItem(
                  entry.value,
                  position: entry.key + 1,
                ),
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

  Widget _buildRankingItem(Wine wine, {required int position}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A1C1C18),
            blurRadius: 32,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 40,
            child: Text(
              position.toString(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontSize: 34,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primary.withAlpha((0.28 * 255).round()),
                  ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
            ),
            child: wine.imageUrl.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      wine.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  )
                : const Icon(
                    LucideIcons.wine,
                    color: AppTheme.primary,
                    size: 24,
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _rankDisplayName(wine),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 15,
                        height: 1.1,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  wine.tag,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontSize: 11,
                        letterSpacing: 0.8,
                        color: AppTheme.secondary,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _rankDisplayScore(wine, position),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 15,
                      color: AppTheme.primary,
                    ),
              ),
              const SizedBox(height: 2),
              const Icon(
                Icons.star,
                size: 16,
                color: AppTheme.secondary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Wine> _orderedWineRanking(List<Wine> ranking) {
    const preferredOrder = [
      'Radal Reserve',
      'Condor Peak',
      'Pueblo del Sol',
    ];

    final byName = <String, Wine>{
      for (final wine in ranking) wine.name: wine,
    };
    final ordered = <Wine>[];

    for (final name in preferredOrder) {
      final wine = byName.remove(name);
      if (wine != null) {
        ordered.add(wine);
      }
    }

    ordered.addAll(byName.values);
    return ordered;
  }

  String _rankDisplayName(Wine wine) {
    final origin = wine.origin.toLowerCase();
    final flag = origin == 'chile'
        ? '🇨🇱'
        : origin == 'argentina'
            ? '🇦🇷'
            : (origin == 'uruguai' || origin == 'uruguay')
                ? '🇺🇾'
                : '';

    return flag.isEmpty ? wine.name : '$flag ${wine.name}';
  }

  String _rankDisplayScore(Wine wine, int position) {
    switch (wine.name) {
      case 'Radal Reserve':
        return '4.8';
      case 'Condor Peak':
        return '4.6';
      case 'Pueblo del Sol':
        return '4.5';
      default:
        if (position == 1) return '4.8';
        if (position == 2) return '4.6';
        if (position == 3) return '4.5';
        return wine.score;
    }
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
