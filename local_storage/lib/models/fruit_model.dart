class FruitModel {
  int? id;
  String? fruitName;
  String? fruitQuantity;

  FruitModel({this.id, this.fruitName, this.fruitQuantity});

  FruitModel fromJson(json) {
    return FruitModel(
        id: json['id'],
        fruitName: json['fruitName'],
        fruitQuantity: json['fruitQuantity']);
  }

  Map<String, dynamic> toJson() {
    return {'fruitName': fruitName, 'fruitQuantity': fruitQuantity};
  }
}
