class Product {
  final int id;
  final String name;
  final String category;
  final String image;
  final String description;
  final double price;
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
    required this.description,
    required this.price,
    this.quantity = 0,  // Default quantity is 0
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'image': image,
    'price': price,
   'category':category,
   'quantity': quantity
  };

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      price: json['price'],
      category:json['category'],
      quantity: json['quantity'],
    );
  }

  // Convert a Product object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'name': name,
      'price': price,
      'image': image,
      'quantity': quantity,
      'description':description,
      'category':category,
    };
  }
  // Create a Product object from a Map
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      image: map['image'],
      quantity: map['quantity'],
      description: map['description'],
      category: map['category'],
    );
  }
}
