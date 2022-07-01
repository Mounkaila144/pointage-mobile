import 'package:http/http.dart' as http;
import 'package:mobile/Auth/services/Crud.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'article.dart';
class Remote{
  Future<List<Article>?> getArticle() async {
    const url = 'https://islem.allcine227.com/api/societes.json';
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      final body =response.body;
      return articleFromJson(body);
    }
  }
  static final HttpWithMiddleware https =
  HttpWithMiddleware.build(middlewares: [
    HttpLogger(logLevel: LogLevel.BODY),
  ]);
   Future<List<Notificationpoint>?> getNotif() async {
     SharedPreferences _prefs = await SharedPreferences.getInstance();
     var id = _prefs.getInt('id');
    var url = 'https://192.168.43.219:8000/api/notifications?employee.id=$id';
    final response = await https.get(Uri.parse(url), headers:buildHeaders());

    if(response.statusCode == 200){
      final body =response.body;
      return notificationFromJson(body);
    }
  }
  Future<List<Autorisation>?> getAuth() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var id = _prefs.getInt('id');
    var url = 'https://192.168.43.219:8000/api/autorisations?emploiyee=$id';
    final response = await https.get(Uri.parse(url), headers:buildHeaders());

    if(response.statusCode == 200){
      final body =response.body;
      return autorisationFromJson(body);
    }
  }

  static Map<String, String> buildHeaders({String? accessToken}) {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    return headers;
  }

}
