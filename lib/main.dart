import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brindar/core/theme.dart';
import 'package:brindar/core/services/wine_service.dart';
import 'package:brindar/core/services/auth_service.dart';
import 'package:brindar/core/services/storage_service.dart';
import 'package:brindar/core/providers/wine_provider.dart';
import 'package:brindar/features/splash/splash_view.dart';
import 'package:brindar/features/home/home_view.dart';
import 'package:brindar/features/scan/scan_view.dart';
import 'package:brindar/features/library/library_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => WineService()),
        Provider(create: (_) => AuthService()),
        Provider(create: (_) => StorageService()),
        ChangeNotifierProxyProvider<WineService, WineProvider>(
          create: (context) => WineProvider(context.read<WineService>()),
          update: (context, service, previous) => previous ?? WineProvider(service),
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
      },
    );
  }
}
