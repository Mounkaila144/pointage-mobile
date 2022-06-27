import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'albumbe.dart';
import 'article.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future <List<Article>> articlefuture=getArticle();

  static Future<List<Article>> getArticle() async {
    const url='https://allcine227.com/api/articles.json';
    final response=await http.get(Uri.parse(url));
    final body=json.decode(response.body);
    return body.map<Article>(Article.fromJson).toList();
  }
  late Future<Album> futureAlbum;

  Future<Album> fetchAlbum() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
    if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }



  @override

  Widget build(BuildContext context) {
    return
      FutureBuilder<Album>(
      future: futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(children: [
              Text(snapshot.data!.title)

          ],);

        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },

    );
  }
}
