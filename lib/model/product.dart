class Product {
  Product({
    required this.name,
    this.productId,
  });

  String name = '-';
  String? productId;

  Product.fromJson(dynamic json, int index) {
    name = json['title'];
    productId = 'U-' + index.toString().padLeft(4, '0');
  }
}
