// To parse this JSON data, do
//
//     final article = articleFromJson(jsonString);

import 'dart:convert';

Article articleFromJson(String str) => Article.fromJson(json.decode(str));

String articleToJson(Article data) => json.encode(data.toJson());

class Article {
  Article({
    required this.token,
    required this.data,
  });

  String token;
  Data data;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    token: json["token"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.id,
  });

  int id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}
// To parse this JSON data, do
//
//     final demandeAutorisation = demandeAutorisationFromJson(jsonString);


DemandeAutorisation demandeAutorisationFromJson(String str) => DemandeAutorisation.fromJson(json.decode(str));

String demandeAutorisationToJson(DemandeAutorisation data) => json.encode(data.toJson());

class DemandeAutorisation {
  DemandeAutorisation({
    required this.id,
    required this.emploiyee,
    required this.date,
    required this.status,
  });

  int id;
  String emploiyee;
  DateTime date;
  int status;

  factory DemandeAutorisation.fromJson(Map<String, dynamic> json) => DemandeAutorisation(
    id: json["id"],
    emploiyee: json["emploiyee"],
    date: DateTime.parse(json["date"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "emploiyee": emploiyee,
    "date": date.toIso8601String(),
    "status": status,
  };
}
// To parse this JSON data, do
//
//     final notificationUn = notificationUnFromJson(jsonString);

NotificationUn notificationUnFromJson(String str) => NotificationUn.fromJson(json.decode(str));

String notificationUnToJson(NotificationUn data) => json.encode(data.toJson());

class NotificationUn {
  NotificationUn({
    required this.id,
    required this.employee,
    required this.groupemployer,
    required this.message,
    required this.type,
  });

  int id;
  List<String> employee;
  List<dynamic> groupemployer;
  String message;
  String type;

  factory NotificationUn.fromJson(Map<String, dynamic> json) => NotificationUn(
    id: json["id"],
    employee: List<String>.from(json["employee"].map((x) => x)),
    groupemployer: List<dynamic>.from(json["groupemployer"].map((x) => x)),
    message: json["message"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "employee": List<dynamic>.from(employee.map((x) => x)),
    "groupemployer": List<dynamic>.from(groupemployer.map((x) => x)),
    "message": message,
    "type": type,
  };
}
// To parse this JSON data, do
//
//     final entrerSortire = entrerSortireFromJson(jsonString);

EntrerSortire entrerSortireFromJson(String str) => EntrerSortire.fromJson(json.decode(str));

String entrerSortireToJson(EntrerSortire data) => json.encode(data.toJson());

class EntrerSortire {
  EntrerSortire({
    required this.id,
    required this.type,
    required this.date,
    required this.emploiyee,
  });

  int id;
  String type;
  DateTime date;
  String emploiyee;

  factory EntrerSortire.fromJson(Map<String, dynamic> json) => EntrerSortire(
    id: json["id"],
    type: json["type"],
    date: DateTime.parse(json["date"]),
    emploiyee: json["emploiyee"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "date": date.toIso8601String(),
    "emploiyee": emploiyee,
  };
}



