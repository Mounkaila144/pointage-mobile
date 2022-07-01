// To parse this JSON data, do
//
//     final autorisation = autorisationFromJson(jsonString);

import 'dart:convert';

List<Autorisation> autorisationFromJson(String str) => List<Autorisation>.from(json.decode(str).map((x) => Autorisation.fromJson(x)));

String autorisationToJson(List<Autorisation> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Autorisation {
  Autorisation({
    required this.id,
    required this.emploiyee,
    required this.date,
    required this.status,
  });

  int id;
  String emploiyee;
  DateTime date;
  int status;

  factory Autorisation.fromJson(Map<String, dynamic> json) => Autorisation(
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
//     final emploiyee = emploiyeeFromJson(jsonString);

List<Emploiyee> emploiyeeFromJson(String str) => List<Emploiyee>.from(json.decode(str).map((x) => Emploiyee.fromJson(x)));

String emploiyeeToJson(List<Emploiyee> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Emploiyee {
  Emploiyee({
    required this.id,
    required this.email,
    required this.roles,
    required this.password,
    required this.nom,
    required this.prenom,
    required this.autorisations,
    required this.naissance,
    required this.notificatons,
    required this.pointages,
    required this.userIdentifier,
    required this.verified,
  });

  int id;
  String email;
  List<String> roles;
  String password;
  String nom;
  String prenom;
  List<String> autorisations;
  DateTime naissance;
  List<String> notificatons;
  List<String> pointages;
  String userIdentifier;
  bool verified;

  factory Emploiyee.fromJson(Map<String, dynamic> json) => Emploiyee(
    id: json["id"],
    email: json["email"],
    roles: List<String>.from(json["roles"].map((x) => x)),
    password: json["password"],
    nom: json["nom"],
    prenom: json["prenom"],
    autorisations: List<String>.from(json["autorisations"].map((x) => x)),
    naissance: DateTime.parse(json["naissance"]),
    notificatons: List<String>.from(json["notificatons"].map((x) => x)),
    pointages: List<String>.from(json["pointages"].map((x) => x)),
    userIdentifier: json["userIdentifier"],
    verified: json["verified"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "roles": List<dynamic>.from(roles.map((x) => x)),
    "password": password,
    "nom": nom,
    "prenom": prenom,
    "autorisations": List<dynamic>.from(autorisations.map((x) => x)),
    "naissance": naissance.toIso8601String(),
    "notificatons": List<dynamic>.from(notificatons.map((x) => x)),
    "pointages": List<dynamic>.from(pointages.map((x) => x)),
    "userIdentifier": userIdentifier,
    "verified": verified,
  };
}

// To parse this JSON data, do
//
//     final pointage = pointageFromJson(jsonString);
List<Pointage> pointageFromJson(String str) => List<Pointage>.from(json.decode(str).map((x) => Pointage.fromJson(x)));

String pointageToJson(List<Pointage> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pointage {
  Pointage({
    required this.id,
    required this.type,
    required this.date,
    required this.emploiyee,
  });

  int id;
  String type;
  DateTime date;
  String emploiyee;

  factory Pointage.fromJson(Map<String, dynamic> json) => Pointage(
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
// To parse this JSON data, do
//
//     final notification = notificationFromJson(jsonString);

List<Notificationpoint> notificationFromJson(String str) => List<Notificationpoint>.from(json.decode(str).map((x) => Notificationpoint.fromJson(x)));

String notificationToJson(List<Notificationpoint> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Notificationpoint {
  Notificationpoint({
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

  factory Notificationpoint.fromJson(Map<String, dynamic> json) => Notificationpoint(
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

//1
// To parse this JSON data, do
//
//     final employee1 = employee1FromJson(jsonString);
Employee1 employee1FromJson(String str) => Employee1.fromJson(json.decode(str));

String employee1ToJson(Employee1 data) => json.encode(data.toJson());

class Employee1 {
  Employee1({
    required  this.id,
    required this.email,
    required this.roles,
    required this.password,
    required this.nom,
    required this.prenom,
    required this.autorisations,
    required this.naissance,
    required this.notificatons,
    required this.pointages,
    required this.userIdentifier,
    required this.verified,
  });

  int id;
  String email;
  List<String> roles;
  String password;
  String nom;
  String prenom;
  List<dynamic> autorisations;
  DateTime naissance;
  List<String> notificatons;
  List<String> pointages;
  String userIdentifier;
  bool verified;

  factory Employee1.fromJson(Map<String, dynamic> json) => Employee1(
    id: json["id"],
    email: json["email"],
    roles: List<String>.from(json["roles"].map((x) => x)),
    password: json["password"],
    nom: json["nom"],
    prenom: json["prenom"],
    autorisations: List<dynamic>.from(json["autorisations"].map((x) => x)),
    naissance: DateTime.parse(json["naissance"]),
    notificatons: List<String>.from(json["notificatons"].map((x) => x)),
    pointages: List<String>.from(json["pointages"].map((x) => x)),
    userIdentifier: json["userIdentifier"],
    verified: json["verified"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "roles": List<dynamic>.from(roles.map((x) => x)),
    "password": password,
    "nom": nom,
    "prenom": prenom,
    "autorisations": List<dynamic>.from(autorisations.map((x) => x)),
    "naissance": naissance.toIso8601String(),
    "notificatons": List<dynamic>.from(notificatons.map((x) => x)),
    "pointages": List<dynamic>.from(pointages.map((x) => x)),
    "userIdentifier": userIdentifier,
    "verified": verified,
  };
}
