import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/Auth/services/Crud.dart';
import 'package:mobile/Home.dart';
import 'package:mobile/MyHomePage.dart';
import 'package:mobile/Page/Profile.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import '../Auth/Animation/FadeAnimation.dart';
import '../Auth/exceptions/form_exceptions.dart';
import '../Auth/services/User.dart';
import '../Auth/services/auth_service.dart';
import 'package:jwt_decode/jwt_decode.dart';
import '../Auth/services/helper_service.dart';
import '../Liste.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => LoginState();

  void Deconnecter() {
    LoginState().Deconnexion();
  }
}

class LoginState extends State<Login> {
  void upDateSharedPreferences(String token, int id) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString('token', token);
    _prefs.setInt('id', id);
  }

  Future<String?> token(String key) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    return token;
  }

  bool connect = false;

  void Connexion() {
    setState(() {
      connect = true;
    });
  }

  void Deconnexion() {
    setState(() async {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      await _prefs.remove('token');
      await _prefs.remove('id');
    });
  }

  static final HttpWithMiddleware https =
      HttpWithMiddleware.build(middlewares: [
    HttpLogger(logLevel: LogLevel.BODY),
  ]);

  Future<Article> login({
    required String email,
    required String password,
  }) async {
    final response = await https.post(
      HelperService.buildUri("login_check"),
      headers: HelperService.buildHeaders(),
      body: jsonEncode(
        {
          'email': email,
          'password': password,
        },
      ),
    );

    final statusType = (response.statusCode);
    switch (statusType) {
      case 200:
        final user = articleFromJson(response.body);
        Map<String, dynamic> payload = Jwt.parseJwt(user.token);
        print(payload);
        upDateSharedPreferences(user.token, user.data.id);
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

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
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
                                    child: TextField(
                                      controller: emailController,
                                      decoration: InputDecoration(
                                          hintText: "Email or Phone number",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade200))),
                                    child: TextField(
                                      controller: passwordController,
                                      decoration: InputDecoration(
                                          hintText: "Password",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 40,
                        ),
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
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    await prefs.remove('token');
                                    await prefs.remove('id');
                                    await login(
                                        email: emailController.text,
                                        password: passwordController.text);
                                    SharedPreferences _prefs =
                                        await SharedPreferences.getInstance();
                                    var token = _prefs.getString('token');
                                    var id = _prefs.getInt('id');
                                    print("token $token");
                                    print("id $id");
                                    bool expire = Jwt.isExpired(token!);
                                    if (!expire) {
                                      print("tu est connecter felicitation");
                                      await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => expire
                                                  ? Login()
                                                  : MyHomePage(title: "Menu")));
                                    } else {
                                      print("tu n,est pas connecter");
                                    }
                                  },
                                  child: Text(
                                    "Login",
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
  }
}
