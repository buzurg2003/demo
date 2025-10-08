import 'package:flutter/material.dart';

import '../../../data/local/stock_hive_repo.dart';
import '../../../data/models/stock.dart';

class StocksPage extends StatefulWidget {
  const StocksPage({super.key});

  @override
  State<StocksPage> createState() => _StocksPageState();
}

class _StocksPageState extends State<StocksPage> {
  final repo = StockHiveRepository();

  final _warehouseCtrl = TextEditingController();
  final _gtinCtrl = TextEditingController();
  final _qtyCtrl = TextEditingController();

  @override
  void dispose() {
    _warehouseCtrl.dispose();
    _gtinCtrl.dispose();
    _qtyCtrl.dispose();
    super.dispose();
  }

  void _addStock() async {
    final w = _warehouseCtrl.text.trim();
    final g = _gtinCtrl.text.trim();
    final q = int.tryParse(_qtyCtrl.text) ?? 0;
    if (w.isEmpty || g.isEmpty || q <= 0) return;

    final existing = repo.getByWarehouseAndGtin(w, g);
    if (existing != null) {
      existing.quantity += q;
      await repo.updateStock(existing);
    } else {
      final s = Stock(warehouse: w, gtin: g, quantity: q);
      await repo.addStock(s);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final allStocks = repo.getAll();

    return Scaffold(
      appBar: AppBar(title: const Text('Остатки')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _warehouseCtrl,
                    decoration: const InputDecoration(labelText: 'Склад'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _gtinCtrl,
                    decoration: const InputDecoration(labelText: 'GTIN'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _qtyCtrl,
                    decoration: const InputDecoration(labelText: 'Количество'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                IconButton(
                  onPressed: _addStock,
                  icon: const Icon(Icons.add_circle, color: Colors.blue),
                ),
              ],
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: allStocks.length,
                itemBuilder: (_, i) {
                  final s = allStocks[i];
                  return ListTile(
                    title: Text('${s.warehouse} — ${s.gtin}'),
                    subtitle: Text('Количество: ${s.quantity}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
