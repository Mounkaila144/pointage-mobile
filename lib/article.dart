// To parse this JSON data, do
//
//     final article = articleFromJson(jsonString);

import 'dart:convert';

List<Article> articleFromJson(String str) => List<Article>.from(json.decode(str).map((x) => Article.fromJson(x)));

String articleToJson(List<Article> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Article {
  Article({
    this.id,
    this.nom,
    this.localisation,
    this.dureePause,
    this.nombreEmloyee,
    this.heureDebutTravail,
    this.heureFinTravail,
  });

  int? id;
  String? nom;
  String? localisation;
  String? dureePause;
  int? nombreEmloyee;
  DateTime? heureDebutTravail;
  DateTime? heureFinTravail;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    id: json["id"],
    nom: json["nom"],
    localisation: json["localisation"],
    dureePause: json["dureePause"],
    nombreEmloyee: json["nombreEmloyee"],
    heureDebutTravail: DateTime.parse(json["heureDebutTravail"]),
    heureFinTravail: DateTime.parse(json["heureFinTravail"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nom": nom,
    "localisation": localisation,
    "dureePause": dureePause,
    "nombreEmloyee": nombreEmloyee,
    "heureDebutTravail": heureDebutTravail?.toIso8601String(),
    "heureFinTravail": heureFinTravail?.toIso8601String(),
  };
}
