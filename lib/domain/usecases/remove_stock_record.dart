import '../repositories/i_stock_repository.dart';

class RemoveStockRecord {
  final IStockRepository repo;
  RemoveStockRecord(this.repo);

  Future<void> execute(String warehouse, String gtin, int quantity) async {
    await repo.removeStock(warehouse, gtin, quantity);
  }
}
