import 'package:hive/hive.dart';

import '../../data/models/product.dart';
import '../../domain/repositories/i_product_repository.dart';
import '../local/hive_provider.dart';

class ProductHiveRepository implements IProductRepository {
  final Box<Product> box = HiveProvider.getProductsBox();

  @override
  Future<void> addProduct(Product product) async {
    await box.put(product.gtin, product);
  }

  @override
  Future<void> updateProduct(Product product) async {
    await product.save();
  }

  @override
  Future<void> deleteProduct(String gtin) async {
    final p = box.get(gtin);
    if (p != null) {
      p.isDeleted = true;
      p.deletedAt = DateTime.now();
      await p.save();
    }
  }

  @override
  Product? getByGtin(String gtin) => box.get(gtin);

  @override
  List<Product> getAll({bool includeDeleted = false}) {
    final items = box.values.toList();
    if (includeDeleted) return items;
    return items.where((p) => !p.isDeleted).toList();
  }
}
