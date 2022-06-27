import 'package:http/http.dart' as http;
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
}