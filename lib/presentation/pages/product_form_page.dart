import 'package:flutter/material.dart';

import '../../core/utils/gtin_validator.dart';
import '../../data/models/product.dart';

class ProductFormPage extends StatefulWidget {
  final Product? product; // если редактирование

  const ProductFormPage({super.key, this.product});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _gtinCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _nameCtrl.text = widget.product!.name;
      _gtinCtrl.text = widget.product!.gtin;
      _priceCtrl.text = widget.product!.price.toString();
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _gtinCtrl.dispose();
    _priceCtrl.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    // собираем объект Product и вызываем usecase/repo
    final p = Product(
      gtin: _gtinCtrl.text.trim(),
      name: _nameCtrl.text.trim(),
      price: double.tryParse(_priceCtrl.text.trim()) ?? 0.0,
    );
    // Тут: вызвать репозиторий/Usecase. Для примера просто Navigator.pop
    Navigator.of(context).pop(p);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.product != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Редактировать товар' : 'Добавить товар'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: InputDecoration(labelText: 'Название'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Введите название' : null,
              ),
              TextFormField(
                controller: _gtinCtrl,
                decoration: InputDecoration(labelText: 'GTIN (13 цифр)'),
                keyboardType: TextInputType.number,
                validator: (v) => (v == null || !isValidGtin13(v.trim()))
                    ? 'GTIN должен содержать ровно 13 цифр'
                    : null,
                enabled: !isEdit, // обычно GTIN неизменяемый ключ
              ),
              TextFormField(
                controller: _priceCtrl,
                decoration: InputDecoration(labelText: 'Цена'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (v) => (v == null || double.tryParse(v) == null)
                    ? 'Введите корректную цену'
                    : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _save, child: Text('Сохранить')),
            ],
          ),
        ),
      ),
    );
  }
}
