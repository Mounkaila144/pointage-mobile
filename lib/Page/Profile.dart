import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:mobile/Auth/services/Crud.dart';
import 'package:mobile/Page/message.dart';
import 'package:mobile/Page/theme.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Auth/Animation/FadeAnimation.dart';
import '../Auth/exceptions/form_exceptions.dart';
import '../Auth/services/helper_service.dart';
import '../albumbe.dart';
import 'package:http/http.dart' as http;


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Future<Employee1> futureEmployee1=fetchEmployee1();
  static final HttpWithMiddleware https =
  HttpWithMiddleware.build(middlewares: [
    HttpLogger(logLevel: LogLevel.BODY),
  ]);

  Future<Employee1> fetchEmployee1() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var id = _prefs.getInt('id');
    final response = await https.get(
      HelperService.buildUri("employees/$id"),
    );

    final statusType = (response.statusCode);
    switch (statusType) {
      case 200:
        final user=employee1FromJson(response.body);
        return user;
      case 400:
        final json = jsonDecode(response.body);
        throw handleFormErrors(json);
      case 300:
      case 500:
      default:
        throw FormGeneralException(message: 'Error contacting the server!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Employee1>(
      future: futureEmployee1,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return  Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text("Profile Employer N° ${snapshot.data!.id}"),
              ),
              body: themejolie(donner: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child:Column(
                  children: [
                    Material(
                      type: MaterialType.circle,
                      color: Colors.deepOrange.shade900,
                      child:Icon(Icons.perm_identity ,color: Colors.white,size: 200,) ,
                    ),
                    FadeAnimation(1, Text(snapshot.data!.prenom, style: TextStyle(color: Colors.white, fontSize: 40),))
                  ],
                ) ,
              ),
              Row(
                children: [
                  Icon(Icons.account_circle ,color: Colors.deepOrange.shade900,size: 40,),
                  SizedBox(
                    width: 10,
                  ),
                  FadeAnimation(1, Text("Employer N°${snapshot.data!.id}", style: TextStyle(color: Colors.white, fontSize: 25),)),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.email ,color: Colors.deepOrange.shade900,size: 40,),
                  SizedBox(
                    width: 10,
                  ),
                  FadeAnimation(1, Text(snapshot.data!.email, style: TextStyle(color: Colors.white, fontSize: 25),)),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.date_range ,color: Colors.deepOrange.shade900,size: 40,),
                  SizedBox(
                    width: 10,
                  ),
                  FadeAnimation(1, Text("Naissance : ${snapshot.data!.naissance.day}/${snapshot.data!.naissance.month}/${snapshot.data!.naissance.year}",style: TextStyle(color: Colors.white, fontSize: 25))),
                ],
              ),
            ],
          ),
          ),
          );

        }

        else { // By default, show a loading spinner.
          return Messageeror();
        }
      },
    );
  }
}

