class Product {
  Product({
    this.name,
  });

  String? name;

  Product.fromJson(dynamic json) {
    name = json['title'];
  }
}