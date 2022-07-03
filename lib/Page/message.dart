import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/Page/ENteSortir.dart';
import 'package:mobile/Page/theme.dart';
import 'package:mobile/face/face.dart';

import '../Auth/Animation/FadeAnimation.dart';

class Messageeror extends StatelessWidget {
  const Messageeror({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      themejolie(
      donner: Center(
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            FadeAnimation(1, Text("Eureur   de chargement ", style: TextStyle(color: Colors.white, fontSize: 60),))
            ,
            SizedBox(
              height: 70,
            ),
            FadeAnimation(
              1.6,
              Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 50),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.red[900]),
                child: Center(
                  child:TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    child: Text("Retour", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class Messagepointage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return
      themejolie(
      donner: Center(
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            FadeAnimation(1, Text("Eureur du Pointage Veuille Ressayer ", style: TextStyle(color: Colors.white, fontSize: 25),))
            ,
            SizedBox(
              height: 70,
            ),
            FadeAnimation(
              1.6,
              Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 50),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.red[900]),
                child: Center(
                  child:TextButton(
                    onPressed: () async {
                      Navigator.push(context, MaterialPageRoute(builder:
                          (context)=>FacePage()));
                    },
                    child: Text("Recharger", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class MessageSucces extends StatefulWidget {
  const MessageSucces({Key? key}) : super(key: key);

  @override
  State<MessageSucces> createState() => _MessageSuccesState();
}

class _MessageSuccesState extends State<MessageSucces> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Timer(Duration(seconds:5),(){
        Navigator.push(context, MaterialPageRoute(builder:
            (context)=>Porte()));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      themejolie(
        donner: Center(
          child: Column(
            children: [
              SizedBox(
                height: 200,
              ),
              Card(
                color: Colors.green.shade800,
                shadowColor: Colors.amber,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child:FadeAnimation(1, Text("Pointage Réusssi avec succès", style: TextStyle(color: Colors.white, fontSize: 50),))

              ),
              SizedBox(
                height: 70,
              ),
            ],
          ),
        ),
      );
  }
}
