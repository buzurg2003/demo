import '../../data/models/stock.dart';

abstract class IStockRepository {
  /// Добавить новую запись или обновить существующую (если GTIN+склад совпадают)
  Future<void> addStock(Stock stock);

  /// Обновить существующую запись
  Future<void> updateStock(Stock stock);

  /// Уменьшить количество товара на складе (с валидацией)
  Future<void> removeStock(String warehouse, String gtin, int quantity);

  /// Получить запись по складу и GTIN
  Stock? getByWarehouseAndGtin(String warehouse, String gtin);

  /// Получить все записи (по всем складам)
  List<Stock> getAll();

  /// Получить все записи по определённому складу
  List<Stock> getByWarehouse(String warehouse);

  /// Удалить запись (если нужно полностью убрать)
  Future<void> deleteStock(String warehouse, String gtin);
}
