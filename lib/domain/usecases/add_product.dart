import '../../data/models/product.dart';
import '../repositories/i_product_repository.dart';

class AddProduct {
  final IProductRepository repo;
  AddProduct(this.repo);

  Future<void> execute(Product product) async {
    // можно добавить проверку GTIN или уникальность
    final exists = repo.getByGtin(product.gtin);
    if (exists != null) {
      throw Exception('Product with GTIN already exists');
    }
    await repo.addProduct(product);
  }
}
