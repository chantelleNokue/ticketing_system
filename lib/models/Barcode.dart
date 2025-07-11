import 'dart:convert';

class Barcode {
  String? barcode;
  String? productType;
  String? productId;
  int? productPrice;
  String? statusId;
  String? status;

  Barcode({
    this.barcode,
    this.productType,
    this.productId,
    this.productPrice,
    this.statusId,
    this.status,
  });

  factory Barcode.fromJson(String str) => Barcode.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Barcode.fromMap(Map<String, dynamic> json) => Barcode(
        barcode: json["barcode"],
        productType: json["productType"],
        productId: json["productId"],
        productPrice: json["productPrice"],
        statusId: json["statusId"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "barcode": barcode,
        "productType": productType,
        "productId": productId,
        "productPrice": productPrice,
        "statusId": statusId,
        "status": status,
      };
}
