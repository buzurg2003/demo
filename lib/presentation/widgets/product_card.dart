import 'dart:io';

import 'package:flutter/material.dart';

import '../../../data/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProductCard({
    super.key,
    required this.product,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final img = product.imagePath != null
        ? Image.file(File(product.imagePath!))
        : const Icon(Icons.image);

    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: img,
        title: Text(product.name),
        subtitle: Text(
          'GTIN: ${product.gtin}\nЦена: ${product.price.toStringAsFixed(2)}',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
