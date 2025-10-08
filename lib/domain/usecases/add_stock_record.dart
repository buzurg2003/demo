import '../../data/models/stock.dart';
import '../repositories/i_stock_repository.dart';

class AddStockRecord {
  final IStockRepository repo;
  AddStockRecord(this.repo);

  Future<void> execute(String warehouse, String gtin, int quantity) async {
    if (quantity <= 0) throw Exception('Quantity must be > 0');
    final existing = repo.getByWarehouseAndGtin(warehouse, gtin);
    if (existing != null) {
      existing.quantity += quantity;
      existing.updatedAt = DateTime.now();
      await repo.updateStock(existing);
    } else {
      final newStock = Stock(
        warehouse: warehouse,
        gtin: gtin,
        quantity: quantity,
      );
      await repo.addStock(newStock);
    }
  }
}
