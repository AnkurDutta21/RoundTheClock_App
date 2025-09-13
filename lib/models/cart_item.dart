class CartItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String image;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    this.quantity = 1,
  });

  // Calculate total price for this item
  double get totalPrice => price * quantity;

  // Create a copy with updated quantity
  CartItem copyWith({int? quantity}) {
    return CartItem(
      id: id,
      name: name,
      description: description,
      price: price,
      image: image,
      quantity: quantity ?? this.quantity,
    );
  }

  // Convert to/from JSON for persistence (optional)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image': image,
      'quantity': quantity,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
      quantity: json['quantity'],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartItem && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
