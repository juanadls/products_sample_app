import 'dart:convert';

class Product {
  bool available;
  String name;
  String picture;
  int price;
  String id;

  Product({
    required this.available,
    required this.name,
    required this.picture,
    required this.price,
    required this.id,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        available: json["available"],
        name: json["name"],
        picture: json["picture"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "available": available,
        "name": name,
        "picture": picture,
        "price": price,
      };
}
