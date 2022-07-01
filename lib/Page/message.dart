import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/Page/theme.dart';

import '../Auth/Animation/FadeAnimation.dart';

class Messageeror extends StatelessWidget {
  const Messageeror({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return themejolie(
      donner: Center(
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            FadeAnimation(1, Text("Eureur de chargement des donner ;Rechercher la page ", style: TextStyle(color: Colors.white, fontSize: 25),))
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