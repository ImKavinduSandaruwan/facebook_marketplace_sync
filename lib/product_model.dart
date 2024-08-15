class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String currency;
  final String availability;
  final String condition;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.currency,
    required this.availability,
    required this.condition,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'currency': currency,
      'availability': availability,
      'condition': condition,
      'image_url': imageUrl,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      currency: json['currency'],
      availability: json['availability'],
      condition: json['condition'],
      imageUrl: json['image_url'],
    );
  }
}