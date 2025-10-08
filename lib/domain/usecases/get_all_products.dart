import '../../data/models/product.dart';
import '../repositories/i_product_repository.dart';

class GetAllProducts {
  final IProductRepository repo;
  GetAllProducts(this.repo);

  List<Product> execute({bool includeDeleted = false}) {
    return repo.getAll(includeDeleted: includeDeleted);
  }
}
