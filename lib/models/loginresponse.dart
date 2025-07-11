import 'dart:convert';

class ReturnOrder {
  final String token;
  final String refreshToken;
  final String refreshTokenExpiryTime;

  ReturnOrder({
    required this.token,
    required this.refreshToken,
    required this.refreshTokenExpiryTime,
  });

  factory ReturnOrder.fromJson(String str) =>
      ReturnOrder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ReturnOrder.fromMap(Map<String, dynamic> json) => ReturnOrder(
        token: json["token"],
        refreshToken: json["refreshToken"],
        refreshTokenExpiryTime: json["refreshTokenExpiryTime"],
      );

  Map<String, dynamic> toMap() => {
        "token": token,
        "refreshToken": refreshToken,
        "refreshTokenExpiryTime": refreshTokenExpiryTime,
      };
}
