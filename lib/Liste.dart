import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/service.dart';
import 'article.dart';

class Articlelist extends StatefulWidget {
  const Articlelist({Key? key}) : super(key: key);

  @override
  State<Articlelist> createState() => ArticlelistState();
}

class ArticlelistState extends State<Articlelist> {
  List<Article>? article;
  var isLoaded=false;

  @override
  void initState(){
    super.initState();

    getData();

  }

  getData() async {
    article=await Remote().getArticle();
    if(article!=null){
      setState((){
        isLoaded=true;
      });
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Pointage"),
    ),
    body:Visibility(
      visible: isLoaded,
      child:builder(article)
    ),
    );
  }
}

Widget builder(articles) =>
    ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        return Column(
          children: [
            Card(
              color: Colors.blue[200],
              shadowColor: Colors.amber,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: CircleAvatar(child: Icon(Icons.add)),
                title: Text("${article.nom}"),
                subtitle: Text("${article.id}"),
                trailing: Icon(Icons.train),
              ),
            ),
            const Divider(
              //*iki eleman arasini bolen cizgi
              color: Colors.red,
              thickness: 1,
              height: 10,
              indent: 20,
              //*soldan bosluk
              endIndent: 20, //*sagdan bosluk
            )
          ],
        );
      },

    );


//! Bu yapilar performans Dostu Yapilar degildir cinku herbir eleman hafizada yer tutar az elemaniniz varsa kullanilirsaniz olur ama cok daha buyuk miktarda elemaniniz varsa kullmak pek dogru degildir
//! Mantik su seilde olmali sadece ekranda gorunenler listelesin seklinde digerleride ekrana geldikce olustulsun olmali