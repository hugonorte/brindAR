import 'package:brindar/core/models/wine.dart';

/// Abstract interface for wine data persistence.
/// Swap [LocalWineRepository] for a REST implementation post-MVP
/// without touching any business logic or UI code.
abstract class WineRepository {
  Future<List<Wine>> getAll();
  Future<Wine?> getByBarcode(String barcode);
  Future<void> save(Wine wine);
  Future<void> update(Wine wine);
  Future<void> delete(String id);
}
