import 'dart:convert';

class Tickets {
  final List<Datum> data;
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final int pageSize;
  final bool hasPreviousPage;
  final bool hasNextPage;

  Tickets({
    required this.data,
    required this.currentPage,
    required this.totalPages,
    required this.totalCount,
    required this.pageSize,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });

  factory Tickets.fromJson(String str) => Tickets.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Tickets.fromMap(Map<String, dynamic> json) => Tickets(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
        currentPage: json["currentPage"],
        totalPages: json["totalPages"],
        totalCount: json["totalCount"],
        pageSize: json["pageSize"],
        hasPreviousPage: json["hasPreviousPage"],
        hasNextPage: json["hasNextPage"],
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "currentPage": currentPage,
        "totalPages": totalPages,
        "totalCount": totalCount,
        "pageSize": pageSize,
        "hasPreviousPage": hasPreviousPage,
        "hasNextPage": hasNextPage,
      };
}

class Datum {
  final String barcode;
  final String productType;
  final String productId;
  final int productPrice;
  final String statusId;
  final String status;

  Datum({
    required this.barcode,
    required this.productType,
    required this.productId,
    required this.productPrice,
    required this.statusId,
    required this.status,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
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
