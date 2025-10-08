import '../repositories/i_product_repository.dart';

class DeleteProduct {
  final IProductRepository repo;
  DeleteProduct(this.repo);

  Future<void> execute(String gtin) async {
    await repo.deleteProduct(gtin);
  }
}
