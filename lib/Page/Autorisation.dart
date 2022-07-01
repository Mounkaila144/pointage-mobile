import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/Auth/services/User.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:date_field/date_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Auth/Animation/FadeAnimation.dart';
import '../Auth/exceptions/form_exceptions.dart';
import '../Auth/services/helper_service.dart';

class AutorisationPage extends StatefulWidget {
  const AutorisationPage({Key? key}) : super(key: key);

  @override
  State<AutorisationPage> createState() => _AutorisationPageState();
}

class _AutorisationPageState extends State<AutorisationPage> {
  DateTime? dateSelectione;

  Two(nbr) {
    return (nbr < 10) ? '0$nbr' : nbr.toString();
  }

  static final HttpWithMiddleware https =
      HttpWithMiddleware.build(middlewares: [
    HttpLogger(logLevel: LogLevel.BODY),
  ]);
  final _formKey = GlobalKey<FormState>();
  final dateController = TextEditingController();

  Future<bool> login({
    required String datesorti,
  }) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var id = _prefs.getInt('id');
    final response = await https.post(
      HelperService.buildUri("autorisations"),
      headers: HelperService.buildHeaders(),
      body: jsonEncode(
        {
          'emploiyee': "\/api\/employees\/$id",
          'date': datesorti,
          'status': 1,
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
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.orange.shade900,
          Colors.orange.shade800,
          Colors.orange.shade400
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                      1,
                      Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                      1.3,
                      Text(
                        "Welcome Back",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 60,
                        ),
                        FadeAnimation(
                            1.4,
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromRGBO(
                                            231, 83, 8, 0.30196078431372547),
                                        blurRadius: 20,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade200))),
                                    child: DateTimeFormField(
                                      decoration: const InputDecoration(
                                        hintStyle:
                                            TextStyle(color: Colors.black45),
                                        errorStyle:
                                            TextStyle(color: Colors.redAccent),
                                        border: OutlineInputBorder(),
                                        suffixIcon: Icon(Icons.event_note),
                                        labelText: 'My Super Date Time Field',
                                      ),
                                      firstDate: DateTime.now()
                                          .add(const Duration(days: 10)),
                                      lastDate: DateTime.now()
                                          .add(const Duration(days: 40)),
                                      initialDate: DateTime.now()
                                          .add(const Duration(days: 20)),
                                      autovalidateMode: AutovalidateMode.always,
                                      validator: (DateTime? e) =>
                                          (e?.day ?? 0) == 1
                                              ? 'Please not the first day'
                                              : null,
                                      onDateSelected: (DateTime value) {
                                        print(value);
                                        setState(() {
                                          dateSelectione = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                            1.6,
                            Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.orange[900]),
                              child: Center(
                                child: TextButton(
                                  onPressed: () async {
                                    login(
                                        datesorti:
                                            "${dateSelectione?.year}-${Two(dateSelectione?.month)}-${Two(dateSelectione?.day)}T${Two(dateSelectione?.hour)}:${Two(dateSelectione?.minute)}:${Two(dateSelectione?.second)}+01:00");
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AutorisationPage()));
                                  },
                                  child: Text(
                                    "Demander",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
    ;
  }
}
