import 'package:hive/hive.dart';

part 'product.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  String gtin; // 13 digits

  @HiveField(1)
  String name;

  @HiveField(2)
  double price;

  @HiveField(3)
  bool isDeleted;

  @HiveField(4)
  String? imagePath; // optional: local path

  @HiveField(5)
  DateTime createdAt;

  @HiveField(6)
  DateTime? editedAt;

  @HiveField(7)
  DateTime? deletedAt;

  Product({
    required this.gtin,
    required this.name,
    required this.price,
    this.isDeleted = false,
    this.imagePath,
    DateTime? createdAt,
    this.editedAt,
    this.deletedAt,
  }) : createdAt = createdAt ?? DateTime.now();
}
