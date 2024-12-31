class CurrenyModel {
  String? name;
  String? price;
  String? quantity;
  String? time;

  CurrenyModel({this.name, this.price, this.quantity, this.time});

  CurrenyModel.fromJson(Map<String, dynamic> json) {
    name = json['s'] ?? '';
    price = (json['p'] ?? '') + '\$';
    quantity = json['q'] ?? '';
    time = '';
    try {
      int milliseconds = (json['T'] ?? 0);
      time = DateTime.fromMillisecondsSinceEpoch(milliseconds).toString();
    } catch (error) {
      time = '';
    }
  }
}
