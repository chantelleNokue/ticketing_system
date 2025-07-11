import 'dart:convert';

class ChecledTickets {
  List<Datum>? data;
  int? currentPage;
  int? totalPages;
  int? totalCount;
  int? pageSize;
  bool? hasPreviousPage;
  bool? hasNextPage;

  ChecledTickets({
    this.data,
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.pageSize,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  factory ChecledTickets.fromJson(String str) =>
      ChecledTickets.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChecledTickets.fromMap(Map<String, dynamic> json) => ChecledTickets(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
        currentPage: json["currentPage"],
        totalPages: json["totalPages"],
        totalCount: json["totalCount"],
        pageSize: json["pageSize"],
        hasPreviousPage: json["hasPreviousPage"],
        hasNextPage: json["hasNextPage"],
      );

  Map<String, dynamic> toMap() => {
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
        "currentPage": currentPage,
        "totalPages": totalPages,
        "totalCount": totalCount,
        "pageSize": pageSize,
        "hasPreviousPage": hasPreviousPage,
        "hasNextPage": hasNextPage,
      };
}

class Datum {
  String? barcode;
  String? productType;
  String? productId;
  int? productPrice;
  String? statusId;
  String? status;

  Datum({
    this.barcode,
    this.productType,
    this.productId,
    this.productPrice,
    this.statusId,
    this.status,
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
