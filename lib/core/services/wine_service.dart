import 'dart:async';
import 'package:brindar/core/models/wine.dart';

class WineService {
  // Simulate a wine database
  final List<Wine> _database = [
    Wine.mockRadal(),
    Wine.mockCondor(),
    Wine.mockPueblo(),
  ];

  Future<Wine?> scanBarcode(String code) async {
    // Simulate network/processing delay
    await Future.delayed(const Duration(seconds: 3));
    
    // For this prototype, any scan returns the Radal Reserve
    // In a real app, we would search by 'code'
    return _database.first;
  }

  Future<List<Wine>> getRanking() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _database;
  }

  Future<List<Wine>> getLibrary() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [_database[0], _database[1]]; // Mock saved wines
  }
}
