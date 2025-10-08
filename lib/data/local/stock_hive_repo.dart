import 'package:hive/hive.dart';

import '../../data/models/stock.dart';
import '../../domain/repositories/i_stock_repository.dart';
import '../local/hive_provider.dart';

class StockHiveRepository implements IStockRepository {
  final Box<Stock> box = HiveProvider.getStocksBox();

  @override
  Future<void> addStock(Stock stock) async {
    // Формируем уникальный ключ: "warehouse|gtin"
    final key = '${stock.warehouse}|${stock.gtin}';
    await box.put(key, stock);
  }

  @override
  Future<void> updateStock(Stock stock) async {
    // Найти ключ (warehouse|gtin)
    final key = '${stock.warehouse}|${stock.gtin}';
    if (box.containsKey(key)) {
      await box.put(key, stock);
    }
  }

  @override
  Future<void> removeStock(String warehouse, String gtin, int quantity) async {
    final key = '$warehouse|$gtin';
    final existing = box.get(key);
    if (existing == null) return;

    if (quantity <= 0) {
      throw Exception('Количество для удаления должно быть > 0');
    }

    if (existing.quantity < quantity) {
      throw Exception('Нельзя отнять больше, чем есть на складе');
    }

    existing.quantity -= quantity;
    existing.updatedAt = DateTime.now();

    if (existing.quantity == 0) {
      await box.delete(key); // Если остаток 0 — удаляем запись
    } else {
      await box.put(key, existing);
    }
  }

  @override
  Stock? getByWarehouseAndGtin(String warehouse, String gtin) {
    final key = '$warehouse|$gtin';
    return box.get(key);
  }

  @override
  List<Stock> getAll() {
    return box.values.toList();
  }

  @override
  List<Stock> getByWarehouse(String warehouse) {
    return box.values.where((s) => s.warehouse == warehouse).toList();
  }

  @override
  Future<void> deleteStock(String warehouse, String gtin) async {
    final key = '$warehouse|$gtin';
    if (box.containsKey(key)) {
      await box.delete(key);
    }
  }
}
