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

