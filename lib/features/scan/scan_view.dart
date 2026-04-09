import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
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

class _ScanViewState extends State<ScanView> {
  CameraController? _controller;
  bool _isInit = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) return;

    _controller = CameraController(cameras[0], ResolutionPreset.high);
    await _controller!.initialize();
    if (mounted) {
      setState(() => _isInit = true);
      // Start simulated scan through provider
      context.read<WineProvider>().startScan('MOCK_CODE');
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInit || _controller == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final wineProvider = context.watch<WineProvider>();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Camera Preview
          Positioned.fill(
            child: CameraPreview(_controller!),
          ),

          // Scan Reticle
          if (wineProvider.isScanning) _buildReticle(),

          // AR Overlay (Glassmorphism)
          if (wineProvider.scannedWine != null)
            Positioned(
              bottom: 60,
              left: 20,
              right: 20,
              child: GlassOverlay(
                wine: wineProvider.scannedWine!,
                onDetailsTap: () {},
              ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2),
            ),

          // Top Controls
          Positioned(
            top: 60,
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCircleButton(LucideIcons.x, () {
                  wineProvider.resetScan();
                  Navigator.pop(context);
                }),
                _buildCircleButton(LucideIcons.zap, () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReticle() {
    return Center(
      child: Container(
        width: 250,
        height: 400,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white54, width: 2),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          children: [
            _buildCorner(0, 0, 24, 0),
            _buildCorner(null, 0, 0, 24),
            _buildCorner(0, null, 24, 0),
            _buildCorner(null, null, 0, 24),
            Center(
              child: Container(
                width: 200,
                height: 2,
                color: AppTheme.primaryVariant.withAlpha((0.5 * 255).toInt()),
              ).animate(onPlay: (c) => c.repeat()).moveY(begin: -150, end: 150, duration: 2.seconds, curve: Curves.easeInOut),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCorner(double? top, double? right, double? bottom, double? left) {
    return Positioned(
      top: top,
      right: right,
      bottom: bottom,
      left: left,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          border: Border(
            top: top == 0 ? const BorderSide(color: Colors.white, width: 4) : BorderSide.none,
            right: right == 0 ? const BorderSide(color: Colors.white, width: 4) : BorderSide.none,
            bottom: bottom == 0 ? const BorderSide(color: Colors.white, width: 4) : BorderSide.none,
            left: left == 0 ? const BorderSide(color: Colors.white, width: 4) : BorderSide.none,
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
          color: Colors.black.withAlpha((0.4 * 255).toInt()),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white24),
        ),
        child: Icon(icon, color: Colors.white, size: 24),
      ),
    );
  }
}
