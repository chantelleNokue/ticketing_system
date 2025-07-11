import 'dart:convert';

class MatchEvents {
  final String eventDate;
  final dynamic eventFormat;

  MatchEvents({
    required this.eventDate,
    required this.eventFormat,
  });

  factory MatchEvents.fromJson(String str) =>
      MatchEvents.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MatchEvents.fromMap(Map<String, dynamic> json) => MatchEvents(
        eventDate: json["eventDate"],
        eventFormat: json["eventFormat"],
      );

  Map<String, dynamic> toMap() => {
        "eventDate": eventDate,
        "eventFormat": eventFormat,
      };
}
