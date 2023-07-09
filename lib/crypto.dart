class Crypto {
  Crypto({
    required this.title,
    required this.price,
    required this.changes,
    required this.status,
  });

  String title;
  String price;
  String changes;
  String status;

  factory Crypto.formMapJson(json) {
    return Crypto(
      title: json["title"],
      price: json["price"],
      changes: json["changes"],
      status: json["status"],
    );
  }
}
