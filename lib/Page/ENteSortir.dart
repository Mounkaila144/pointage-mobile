import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/MyHomePage.dart';
import 'package:mobile/Page/theme.dart';
import 'package:mobile/face/face.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Auth/Animation/FadeAnimation.dart';
import '../Auth/exceptions/form_exceptions.dart';
import '../Auth/services/helper_service.dart';

class Porte extends StatelessWidget {
  Porte({
    Key? key,
  }) : super(key: key);
  Two(nbr) {
    return (nbr < 10) ? '0$nbr' : nbr.toString();
  }

  static final HttpWithMiddleware https =
  HttpWithMiddleware.build(middlewares: [
    HttpLogger(logLevel: LogLevel.BODY),
  ]);
  final _formKey = GlobalKey<FormState>();
  final dateController = TextEditingController();

  Future<bool> ActionES({
    required String type,
  }) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var id = _prefs.getInt('id');
    final response = await https.post(
      HelperService.buildUri("pointages"),
      headers: HelperService.buildHeaders(),
      body: jsonEncode(
        {
          'type': type,
          'emploiyee': "\/api\/employees\/$id",
          'date':"${DateTime.now().year}-${Two(DateTime.now().month)}-${Two(DateTime.now().day)}T${Two(DateTime.now().hour)}:${Two(DateTime.now().minute)}:${Two(DateTime.now().second)}+01:00",

        },
      ),
    );
    final statusType = (response.statusCode);
    switch (statusType) {
      case 200:
        return true;
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
    return themejolie(
      donner: Center(
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            FadeAnimation(1, Text("Porte Entrer ou porte sortire ", style: TextStyle(color: Colors.white, fontSize: 25),))
            ,
            SizedBox(
              height: 70,
            ),
            FadeAnimation(
              1.6,
              Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 50),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.blue[900]),
                child: Center(
                  child:TextButton(
                    onPressed: () async {
                      ActionES(type: "entrer");
                      Navigator.push(context, MaterialPageRoute(builder:
                          (context)=>MyHomePage(title: "Porte Entrer")));
                    },
                    child: Text("Entrer", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 70,
            ),
            FadeAnimation(
              1.6,
              Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 50),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.red[900]),
                child: Center(
                  child:TextButton(
                    onPressed: () async {
                      ActionES(type: "sorti");
    Navigator.push(context, MaterialPageRoute(builder:
    (context)=>MyHomePage(title: "Porte de sorti")));
                    },
                    child: Text("Sortir", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}