import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/Auth/services/Crud.dart';
import 'package:mobile/Page/theme.dart';

import '../service.dart';

class AutorisationList extends StatefulWidget {
  const AutorisationList({Key? key}) : super(key: key);

  @override
  State<AutorisationList> createState() => _AutorisationListState();
}

class _AutorisationListState extends State<AutorisationList> {
  List<Autorisation>? auth;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    auth = await Remote().getAuth();
    if (auth != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }
 couleur(nbr){
    if(nbr==2){
      return true;
    }
    if(nbr==3){
      return false;
    }
    else{
      return null;
    }
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des Autorisation"),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.orange.shade700,
          Colors.orange.shade500,
          Colors.orange.shade300
        ])),
        child: Visibility(visible: isLoaded, child: builder(auth)),
      ),
    );
  }
}

Widget builder(List<Autorisation>? authication) => ListView.builder(
      itemCount: authication?.length,
      itemBuilder: (context, index) {
        final auth = authication![index];
        return Column(
          children: [
            Card(
              color:(auth.status)==2? Colors.blue.shade500:((auth.status)==3?Colors.red.shade500:Colors.grey),
              shadowColor: Colors.amber,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: CircleAvatar(child: Icon(Icons.security)),
                title:(auth.status)==2? Text("Status : Autoriser" ,):((auth.status)==3?Text("Status : Refuser"):Text("Status : En Attente")),
                subtitle: Text("Date ${auth.date.day}/${auth.date.month}/${auth.date.year}"),
                trailing: Icon(Icons.man),
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
