import '../../data/models/product.dart';

abstract class IProductRepository {
  Future<void> addProduct(Product product);
  Future<void> updateProduct(Product product);
  Future<void> deleteProduct(String gtin);
  Product? getByGtin(String gtin);
  List<Product> getAll({bool includeDeleted = false});
}
