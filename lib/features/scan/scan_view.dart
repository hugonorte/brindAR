import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:brindar/core/theme.dart';
import 'package:brindar/core/providers/wine_provider.dart';
import 'package:brindar/shared/widgets/glass_overlay.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ScanView extends StatefulWidget {
  const ScanView({super.key});

  @override
  State<ScanView> createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> with WidgetsBindingObserver {
  final MobileScannerController _scanner = MobileScannerController(
    formats: [BarcodeFormat.ean13, BarcodeFormat.upcA],
  );

  bool _hasScanned = false; // prevent multiple triggers per session

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _scanner.stop();
    } else if (state == AppLifecycleState.resumed) {
      _scanner.start();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scanner.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_hasScanned) return;

    final barcode = capture.barcodes.firstOrNull;
    final rawValue = barcode?.rawValue;
    if (rawValue == null || rawValue.isEmpty) return;

    // Accept only EAN-13 (13 digits) or UPC-A (12 digits)
    final isEan13 = rawValue.length == 13 && int.tryParse(rawValue) != null;
    final isUpcA = rawValue.length == 12 && int.tryParse(rawValue) != null;
    if (!isEan13 && !isUpcA) return;

    setState(() => _hasScanned = true);
    _scanner.stop();
    context.read<WineProvider>().startScan(rawValue);
  }

  void _resetScan(WineProvider provider) {
    setState(() => _hasScanned = false);
    provider.resetScan();
    _scanner.start();
  }

  @override
  Widget build(BuildContext context) {
    final wineProvider = context.watch<WineProvider>();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // ── Camera Feed ────────────────────────────────────────────────────
          Positioned.fill(
            child: MobileScanner(
              controller: _scanner,
              onDetect: _onDetect,
            ),
          ),

          // ── Scanning reticle (while idle/scanning) ─────────────────────
          if (wineProvider.scanState == ScanState.idle ||
              wineProvider.scanState == ScanState.scanning)
            _buildReticle(wineProvider.isScanning),

          // ── Wine Found: Glassmorphism Overlay ─────────────────────────────
          if (wineProvider.scanState == ScanState.found &&
              wineProvider.scannedWine != null)
            Positioned(
              bottom: 60,
              left: 20,
              right: 20,
              child: GlassOverlay(
                wine: wineProvider.scannedWine!,
                onDetailsTap: () {},
              ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2),
            ),

          // ── Wine Not Found ────────────────────────────────────────────────
          if (wineProvider.scanState == ScanState.notFound)
            _buildNotFoundPanel(context, wineProvider),

          // ── Top Controls ──────────────────────────────────────────────────
          Positioned(
            top: 60,
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCircleButton(LucideIcons.x, () {
                  _resetScan(wineProvider);
                  Navigator.pop(context);
                }),
                _buildCircleButton(LucideIcons.zap, () => _scanner.toggleTorch()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Not Found Panel ──────────────────────────────────────────────────────────
  Widget _buildNotFoundPanel(BuildContext context, WineProvider provider) {
    return Positioned(
      bottom: 60,
      left: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        decoration: BoxDecoration(
          color: Colors.black.withAlpha((0.75 * 255).toInt()),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(LucideIcons.searchX, color: Colors.white54, size: 40),
            const SizedBox(height: 16),
            Text(
              'Código não encontrado',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              provider.scannedBarcode ?? '',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white54),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppTheme.primaryVariant, width: 1.5),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => Navigator.pushNamed(
                  context,
                  '/register',
                  arguments: provider.scannedBarcode,
                ),
                child: const Text('cadastrar vinho ?'),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => _resetScan(provider),
              child: const Text(
                'escanear novamente',
                style: TextStyle(color: Colors.white54),
              ),
            ),
          ],
        ),
      ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2),
    );
  }

  // ── Scan Reticle ─────────────────────────────────────────────────────────────
  Widget _buildReticle(bool isScanning) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 280,
            height: 180,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white30, width: 1.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                _buildCorner(top: 0, left: 0),
                _buildCorner(top: 0, right: 0),
                _buildCorner(bottom: 0, left: 0),
                _buildCorner(bottom: 0, right: 0),
                if (isScanning)
                  Center(
                    child: Container(
                      width: 240,
                      height: 2,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryVariant
                            .withAlpha((0.8 * 255).toInt()),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primaryVariant
                                .withAlpha((0.5 * 255).toInt()),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ).animate(onPlay: (c) => c.repeat()).moveY(
                          begin: -60,
                          end: 60,
                          duration: 1800.ms,
                          curve: Curves.easeInOut,
                        ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            isScanning ? 'Analisando...' : 'Aponte para o código de barras',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCorner({double? top, double? bottom, double? left, double? right}) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          border: Border(
            top: top != null
                ? const BorderSide(color: Colors.white, width: 3)
                : BorderSide.none,
            bottom: bottom != null
                ? const BorderSide(color: Colors.white, width: 3)
                : BorderSide.none,
            left: left != null
                ? const BorderSide(color: Colors.white, width: 3)
                : BorderSide.none,
            right: right != null
                ? const BorderSide(color: Colors.white, width: 3)
                : BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildCircleButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.black.withAlpha((0.5 * 255).toInt()),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white24),
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }
}
