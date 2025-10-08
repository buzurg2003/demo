import 'package:flutter/material.dart';

import '../../../data/local/product_hive_repo.dart';
import '../../../data/models/product.dart';
import '../widgets/confirm_dialog.dart';
import '../widgets/product_card.dart';
import 'product_form_page.dart';
import 'stocks_page.dart';

class ProductsListPage extends StatefulWidget {
  const ProductsListPage({super.key});

  @override
  State<ProductsListPage> createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  final repo = ProductHiveRepository();

  @override
  Widget build(BuildContext context) {
    final products = repo.getAll();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Список товаров'),
        actions: [
          IconButton(
            icon: const Icon(Icons.warehouse),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const StocksPage()),
            ),
          ),
        ],
      ),
      body: products.isEmpty
          ? const Center(child: Text('Нет товаров'))
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final p = products[index];
                return ProductCard(
                  product: p,
                  onEdit: () async {
                    final updated = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductFormPage(product: p),
                      ),
                    );
                    if (updated != null) setState(() {});
                  },
                  onDelete: () async {
                    final confirm = await showConfirmDialog(
                      context,
                      'Удалить товар?',
                    );
                    if (confirm) {
                      await repo.deleteProduct(p.gtin);
                      setState(() {});
                    }
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newProduct = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProductFormPage()),
          );
          if (newProduct is Product) {
            await repo.addProduct(newProduct);
            setState(() {});
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
