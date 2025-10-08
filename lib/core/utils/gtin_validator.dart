bool isValidGtin13(String gtin) {
  final digitsOnly = RegExp(r'^\d{13}$');
  return digitsOnly.hasMatch(gtin);
}
