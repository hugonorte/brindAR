import 'package:flutter/material.dart';
import 'package:brindar/core/models/wine.dart';
import 'package:brindar/core/services/wine_service.dart';

class WineProvider extends ChangeNotifier {
  final WineService _wineService;
  
  WineProvider(this._wineService);

  List<Wine> _ranking = [];
  List<Wine> _library = [];
  Wine? _scannedWine;
  bool _isScanning = false;
  bool _isLoading = false;

  List<Wine> get ranking => _ranking;
  List<Wine> get library => _library;
  Wine? get scannedWine => _scannedWine;
  bool get isScanning => _isScanning;
  bool get isLoading => _isLoading;

  Future<void> fetchInitialData() async {
    _isLoading = true;
    notifyListeners();
    
    _ranking = await _wineService.getRanking();
    _library = await _wineService.getLibrary();
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> startScan(String code) async {
    _isScanning = true;
    _scannedWine = null;
    notifyListeners();

    _scannedWine = await _wineService.scanBarcode(code);
    _isScanning = false;
    notifyListeners();
  }

  void resetScan() {
    _scannedWine = null;
    _isScanning = false;
    notifyListeners();
  }
}
