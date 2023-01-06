// To parse required this JSON data, do
//
//     final deliveryApp = deliveryAppFromJson(jsonString);

import 'dart:convert';

DeliveryApp deliveryAppFromJson(String str) =>
    DeliveryApp.fromJson(json.decode(str));

String deliveryAppToJson(DeliveryApp data) => json.encode(data.toJson());

class DeliveryApp {
  DeliveryApp({
    required this.category,
    required this.produckList,
  });

  List<Category> category;
  List<ProduckList> produckList;

  factory DeliveryApp.fromJson(Map<String, dynamic> json) => DeliveryApp(
        category: List<Category>.from(
            json["category"].map((x) => Category.fromJson(x))),
        produckList: List<ProduckList>.from(
            json["produckList"].map((x) => ProduckList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category": List<dynamic>.from(category.map((x) => x.toJson())),
        "produckList": List<dynamic>.from(produckList.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    required this.title,
    required this.image,
  });

  String title;
  String image;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        title: json["title"],
        image: json["image"] ?? 'null',
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "image": image,
      };
}

class ProduckList {
  ProduckList({
    required this.menuName,
    required this.image,
    required this.description,
    required this.rating,
    required this.price,
  });

  String menuName;
  String image;
  String description;
  double rating;
  int price;

  factory ProduckList.fromJson(Map<String, dynamic> json) => ProduckList(
        menuName: json["menuName"],
        image: json["image"],
        description: json["description"],
        rating: json["rating"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "MenuName": menuName,
        "image": image,
        "description": description,
        "rating": rating,
        "price": price,
      };
}
