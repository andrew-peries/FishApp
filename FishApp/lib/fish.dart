import 'dart:convert';

List<Fish> fishFromJson(String str) =>
    List<Fish>.from(json.decode(str).map((x) => Fish.fromJson(x)));

String fishToJson(List<Fish> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Fish {
  Fish({
    this.id,
    this.name,
    this.price,
    this.weight,
    this.description,
  });

  String id;
  String name;
  String price;
  String weight;
  String description;

  factory Fish.fromJson(Map<String, dynamic> json) => Fish(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        weight: json["Weight"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "Weight": weight,
        "description": description,
      };
}
