import '../../data/models/product.dart';
import '../repositories/i_product_repository.dart';

class UpdateProduct {
  final IProductRepository repo;
  UpdateProduct(this.repo);

  Future<void> execute(Product product) async {
    product.editedAt = DateTime.now();
    await repo.updateProduct(product);
  }
}
