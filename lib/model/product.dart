class Product {
  Product({
    required this.name,
  });

  String name = '-';

  Product.fromJson(dynamic json) {
    name = json['title'];
  }
}
