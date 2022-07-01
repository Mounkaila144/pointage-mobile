import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:mobile/Auth/services/Crud.dart';
import 'package:mobile/Auth/services/User.dart';
import 'package:mobile/Page/theme.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Auth/Animation/FadeAnimation.dart';
import '../Auth/exceptions/form_exceptions.dart';
import '../Auth/services/helper_service.dart';
import '../albumbe.dart';
import 'package:http/http.dart' as http;

import 'message.dart';


class NotificationOnePage extends StatefulWidget {
  final int id;
  const NotificationOnePage({Key? key,required this.id}) : super(key: key);

  @override
  State<NotificationOnePage> createState() => _NotificationOnePageState(this.id);
}

class _NotificationOnePageState extends State<NotificationOnePage> {
  final int id;

  _NotificationOnePageState(this.id);

  late Future<NotificationUn> futureEmployee1=fetchEmployee1();
  static final HttpWithMiddleware https =
  HttpWithMiddleware.build(middlewares: [
    HttpLogger(logLevel: LogLevel.BODY),
  ]);

  Future<NotificationUn> fetchEmployee1() async {
    final response = await https.get(
      HelperService.buildUri("notifications/$id"),
    );

    final statusType = (response.statusCode);
    switch (statusType) {
      case 200:
        final user=notificationUnFromJson(response.body);
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
    return FutureBuilder<NotificationUn>(
      future: futureEmployee1,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return  Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text("Notification N° ${snapshot.data!.id}"),
              ),
              body: themejolie(donner: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child:Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.category ,color: Colors.deepOrange.shade900,size: 40,),
                        SizedBox(
                          width: 10,
                        ),
                        FadeAnimation(1, Text("Type : ${snapshot.data!.type}", style: TextStyle(color: Colors.white, fontSize: 25),)),
                      ],
                    ),
                  ],
                ) ,
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: Column(
                  children: [
                    Icon(Icons.email ,color: Colors.deepOrange.shade900,size: 40,),
                    SizedBox(
                      width: 10,
                    ),
                    FadeAnimation(1, Text(snapshot.data!.type, style: TextStyle(color: Colors.white, fontSize: 25),)),
                  ],
                ),
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



