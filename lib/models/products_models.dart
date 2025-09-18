class ProductModels {
  final String title;
  final double price;

  int quantity;

  ProductModels({required this.title, required this.price, this.quantity = 1});

  factory ProductModels.fromJson(Map<String, dynamic> json) {
    return ProductModels(
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'price': price, 'quantity': quantity};
  }
}
