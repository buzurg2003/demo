import 'package:hive_flutter/hive_flutter.dart';

import '../models/product.dart';
import '../models/stock.dart';

class HiveProvider {
  static const String productsBox = 'products_box';
  static const String stocksBox = 'stocks_box';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ProductAdapter());
    Hive.registerAdapter(StockAdapter());
    await Hive.openBox<Product>(productsBox);
    await Hive.openBox<Stock>(stocksBox);
  }

  static Box<Product> getProductsBox() => Hive.box<Product>(productsBox);
  static Box<Stock> getStocksBox() => Hive.box<Stock>(stocksBox);
}
