import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brindar/core/theme.dart';
import 'package:brindar/core/repositories/local_wine_repository.dart';
import 'package:brindar/core/providers/wine_provider.dart';
import 'package:brindar/features/splash/splash_view.dart';
import 'package:brindar/features/home/home_view.dart';
import 'package:brindar/features/scan/scan_view.dart';
import 'package:brindar/features/library/library_view.dart';
import 'package:brindar/features/register/register_wine_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // ── Data Layer (Repository Pattern) ──────────────────────────────────
        // To migrate to cloud post-MVP: replace LocalWineRepository with
        // RemoteWineRepository here. No other file needs to change.
        Provider<LocalWineRepository>(
          create: (_) => LocalWineRepository(),
        ),

        // ── State Layer ───────────────────────────────────────────────────────
        ChangeNotifierProxyProvider<LocalWineRepository, WineProvider>(
          create: (ctx) => WineProvider(ctx.read<LocalWineRepository>()),
          update: (ctx, repo, prev) => prev ?? WineProvider(repo),
        ),
      ],
      child: const BrindarApp(),
    ),
  );
}

class BrindarApp extends StatelessWidget {
  const BrindarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brindar',
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashView(),
        '/home': (context) => const HomeView(),
        '/scan': (context) => const ScanView(),
        '/library': (context) => const LibraryView(),
        '/register': (context) => const RegisterWineView(),
      },
    );
  }
}
