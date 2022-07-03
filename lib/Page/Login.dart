import 'dart:convert';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/MyHomePage.dart';
import 'package:mobile/Page/ENteSortir.dart';
import 'package:mobile/face/face.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import '../Auth/Animation/FadeAnimation.dart';
import '../Auth/exceptions/form_exceptions.dart';
import '../Auth/services/User.dart';
import 'package:jwt_decode/jwt_decode.dart';
import '../Auth/services/helper_service.dart';
import 'package:loading_animations/loading_animations.dart';
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
  bool valide = false;
  bool isloading = false;

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
                        "Connecter Vous",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                      1.3,
                      Text(
                        "Bienvenu",
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          valide
                              ? FadeAnimation(
                                  1000,
                                  Text(
                                    "Votre mots de passe ou votre adress email est invalide",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 25),
                                  ))
                              : (isloading
                                  ? LoadingFlipping.circle(
                                      size: 30,
                                      borderColor: Colors.white,
                                    )
                                  : FadeAnimation(
                                      1000,
                                      Text(
                                        "Entrer votre Email et votre mots de passe",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 25),
                                      ))),
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
                                                  color:
                                                      Colors.grey.shade200))),
                                      child: TextFormField(
                                        controller: emailController,
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required(
                                              errorText: "Le champ est vide"),
                                          FormBuilderValidators.email(
                                              errorText:
                                                  "Votre Email n'est pas un email valide"),
                                        ]),
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
                                                  color:
                                                      Colors.grey.shade200))),
                                      child: TextFormField(
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(6,
                                              errorText:
                                                  "Votre mot de passe est inferieur à 6"),
                                          FormBuilderValidators.required(
                                              errorText:
                                                  "Votre mot de passe est vide"),
                                        ]),
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
                                      if (_formKey.currentState!.validate()) {
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        await prefs.remove('token');
                                        await prefs.remove('id');
                                        await login(
                                            email: emailController.text,
                                            password: passwordController.text);
                                        SharedPreferences _prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        var token = _prefs.getString('token');
                                        var id = _prefs.getInt('id');
                                        print("token $token");
                                        print("id $id");
                                        if (token != null) {
                                          setState(() {
                                            isloading = true;
                                          });
                                        }
                                        bool expire = Jwt.isExpired(token!);
                                        if (!expire) {
                                         //await FacePage().FaceUrl();
                                          print(
                                              "tu est connecter felicitation");
                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => expire
                                                      ? Login()
                                                      :FacePage()));
                                        } else {
                                          setState(() {
                                            valide = true;
                                          });
                                          print("tu n,est pas connecter");
                                        }
                                      } else {
                                        setState(() {
                                          valide = true;
                                        });
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
