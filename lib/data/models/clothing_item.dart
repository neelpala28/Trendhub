class ClothingItem {
  final int id;
  final String title;
  final double price;
  final String image;
  final String category;
  int quantity;
  ClothingItem({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.category,
    this.quantity = 1,
  });

  factory ClothingItem.fromJson(Map<String, dynamic> json) {
    return ClothingItem(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      image: json['image'],
      category: json['category'],
    );
  }
}
