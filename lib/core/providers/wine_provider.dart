import 'package:flutter/material.dart';
import 'package:brindar/core/models/wine.dart';
import 'package:brindar/core/repositories/wine_repository.dart';

enum ScanState { idle, scanning, found, notFound }

class WineProvider extends ChangeNotifier {
  final WineRepository _repository;

  WineProvider(this._repository);

  List<Wine> _library = [];
  Wine? _scannedWine;
  String? _scannedBarcode;
  ScanState _scanState = ScanState.idle;
  bool _isLoading = false;

  List<Wine> get library => _library;
  List<Wine> get ranking => [..._library]
    ..sort((a, b) => b.score.compareTo(a.score));
  Wine? get scannedWine => _scannedWine;
  String? get scannedBarcode => _scannedBarcode;
  ScanState get scanState => _scanState;
  bool get isScanning => _scanState == ScanState.scanning;
  bool get isLoading => _isLoading;

  /// Loads all wines from the local database.
  Future<void> fetchInitialData() async {
    _isLoading = true;
    notifyListeners();

    _library = await _repository.getAll();

    _isLoading = false;
    notifyListeners();
  }

  /// Looks up [barcode] (EAN-13 or UPC-A) in the local database.
  /// Sets [scanState] to [ScanState.found] or [ScanState.notFound].
  Future<void> startScan(String barcode) async {
    _scannedBarcode = barcode;
    _scannedWine = null;
    _scanState = ScanState.scanning;
    notifyListeners();

    final result = await _repository.getByBarcode(barcode);

    _scannedWine = result;
    _scanState = result != null ? ScanState.found : ScanState.notFound;
    notifyListeners();
  }

  /// Persists a new wine and refreshes the library.
  Future<void> saveWine(Wine wine) async {
    await _repository.save(wine);
    await fetchInitialData();
    // Show the newly registered wine as the scan result.
    _scannedWine = wine;
    _scanState = ScanState.found;
    notifyListeners();
  }

  /// Updates an existing wine and refreshes the library.
  Future<void> updateWine(Wine wine) async {
    await _repository.update(wine);
    await fetchInitialData();
    notifyListeners();
  }

  /// Deletes a wine by [id] and refreshes the library.
  Future<void> deleteWine(String id) async {
    await _repository.delete(id);
    await fetchInitialData();
    notifyListeners();
  }

  void resetScan() {
    _scannedWine = null;
    _scannedBarcode = null;
    _scanState = ScanState.idle;
    notifyListeners();
  }
}
