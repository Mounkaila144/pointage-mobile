import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/MyHomePage.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'Auth/exceptions/form_exceptions.dart';
import 'Auth/services/User.dart';
import 'Auth/services/auth_service.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'Auth/services/helper_service.dart';
import 'Liste.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => LoginState();
  void Deconnecter(){
    LoginState().Deconnexion();
  }

}

class LoginState extends State<Login> {
  final storage=const FlutterSecureStorage();



  bool connect=false;
  void Connexion() {
    setState((){
     connect=true;
    });
  }
  void Deconnexion() {
    setState(() async {
    //await storage.delete(key: "p");
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
        final user=articleFromJson(response.body);
        Map<String,dynamic> payload=Jwt.parseJwt(user.token);
        print(payload);
        await storage.write(key: 'p', value: user.token);
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
  final emailController=TextEditingController();
  final passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
       body:Form(
        key:_formKey,
      child: ListView(
        children: [
          TextFormField(controller: emailController,),
          TextFormField(controller: passwordController,),
          Center(
            child: TextButton(
              onPressed: () async {

                await login(email: emailController.text, password: passwordController.text);
                var token=await storage.read(key: "p");
                print("token $token");
                bool expire=Jwt.isExpired(token!);
                if(!expire){
                  print("tu est connecter felicitation");
                  await Navigator.push(context, MaterialPageRoute(builder:
                      (context)=>expire ?Login():MyHomePage(title: "Felicitation")));
                }
                else{
                  print("tu n,est pas connecter");
                }
              },
              child: Text("Save"),
            ),
          )
        ],
      ),
    )

    );
  }
}
