import 'package:hive/hive.dart';

part 'stock.g.dart';

@HiveType(typeId: 1)
class Stock extends HiveObject {
  @HiveField(0)
  String warehouse; // склад-строка

  @HiveField(1)
  String gtin; // продукт GTIN

  @HiveField(2)
  int quantity;

  @HiveField(3)
  DateTime updatedAt;

  Stock({
    required this.warehouse,
    required this.gtin,
    required this.quantity,
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? DateTime.now();
}
