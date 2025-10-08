import 'package:hive/hive.dart';

part 'product_entity.g.dart';

/// Модель товара для Hive.
/// Используется для хранения информации о продуктах в локальной базе.
/// Генерация адаптера выполняется командой:
/// flutter packages pub run build_runner build

@HiveType(typeId: 0)
class ProductEntity extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String gtin; // GTIN — 13-значный уникальный код товара

  @HiveField(2)
  bool isActive;

  @HiveField(3)
  double price;

  @HiveField(4)
  String? imagePath; // Локальный путь к изображению (опционально)

  @HiveField(5)
  DateTime createdAt;

  @HiveField(6)
  DateTime updatedAt;

  @HiveField(7)
  DateTime? deletedAt;

  ProductEntity({
    required this.name,
    required this.gtin,
    required this.price,
    this.imagePath,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.deletedAt,
    this.isActive = true,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  /// Проверка, является ли GTIN корректным (13 цифр)
  static bool isValidGtin(String gtin) {
    final regex = RegExp(r'^\d{13}$');
    return regex.hasMatch(gtin);
  }

  /// Обновление данных при редактировании
  void update({
    String? name,
    double? price,
    String? imagePath,
    bool? isActive,
  }) {
    if (name != null) this.name = name;
    if (price != null) this.price = price;
    if (imagePath != null) this.imagePath = imagePath;
    if (isActive != null) this.isActive = isActive;
    updatedAt = DateTime.now();
  }

  /// Пометить товар как удалённый (isActive = false)
  void markAsDeleted() {
    isActive = false;
    deletedAt = DateTime.now();
    updatedAt = DateTime.now();
  }

  /// Преобразование в читаемый формат (для отладки)
  @override
  String toString() {
    return 'ProductEntity(gtin: $gtin, name: $name, price: $price, active: $isActive)';
  }
}
