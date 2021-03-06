import 'package:flutter/material.dart';
import 'package:mobile/Home.dart';
import 'package:mobile/Liste.dart';
import 'package:mobile/Page/Autorisation.dart';
import 'package:mobile/Page/Autorisationlist.dart';
import 'package:mobile/Page/Notification.dart';
import 'package:mobile/Page/Profile.dart';
import 'package:mobile/Page/theme.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

import 'Auth/Animation/FadeAnimation.dart';
import 'Page/Login.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState(this.title);
}

class _MyHomePageState extends State<MyHomePage> {
  bool isOpened = false;
  String title;


  _MyHomePageState(this.title);

  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();

  toggleMenu() {

    final _state = _sideMenuKey.currentState!;
    if (_state.isOpened) {
      _state.closeSideMenu();
    } else {
      _state.openSideMenu();
    }
  }


  @override
  Widget build(BuildContext context) {
    return SideMenu(
      inverse: true,
      // end side menu
      background: Colors.green[700],
      type: SideMenuType.slideNRotate,
      menu: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: buildMenu(),
      ),
      onChange: (_isOpened) {
        setState(() => isOpened = _isOpened);
      },
      child: SideMenu(
        key: _sideMenuKey,
        menu: buildMenu(),
        type: SideMenuType.slideNRotate,
        onChange: (_isOpened) {
          setState(() => isOpened = _isOpened);
        },
        child: IgnorePointer(
          ignoring: isOpened,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => toggleMenu(),
              ),
              title: Text(title),
            ),
            body:
            themejolie(donner: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[


                FadeAnimation(1, Text("Bonjour Bienvenue dans l'Entreprise", style: TextStyle(color: Colors.white, fontSize: 40),)),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
            )
          ),
        ),
      ),
    );
  }
  

  Widget buildMenu() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder:
                  (context)=>MyHomePage(title: "Home")));
            },
            leading: const Icon(Icons.home, size: 30, color: Colors.white),
            title: const Text("Pointage", style: TextStyle(color: Colors.white, fontSize: 16)),
            textColor: Colors.white,
            dense: true,
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder:
                  (context)=>Profile()));
            },
            leading: const Icon(Icons.account_circle,
                size: 30, color: Colors.white),
            title: const Text("Profile", style: TextStyle(color: Colors.white, fontSize: 16)),
            textColor: Colors.white,
            dense: true,

            //
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder:
                  (context)=>Notifationlist()));
            },
            leading: const Icon(Icons.notifications,
                size: 30, color: Colors.white),
            title: const Text("Notification", style: TextStyle(color: Colors.white, fontSize: 16)),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder:
                  (context)=>AutorisationPage()));
            },
            leading:
            const Icon(Icons.security, size: 30, color: Colors.white),
            title: const Text("Demande Autorisation", style: TextStyle(color: Colors.white, fontSize: 16)),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder:
                  (context)=>AutorisationList()));
            },
            leading:
            const Icon(Icons.security, size: 30, color: Colors.white),
            title: const Text("Liste des Autorisation", style: TextStyle(color: Colors.white, fontSize: 16)),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {
             // Login().Deconnecter();
    Navigator.push(context, MaterialPageRoute(builder:
    (context)=>Login()));


            },
            leading:
            const Icon(Icons.logout, size: 30, color: Colors.white),
            title: const Text("Deconexion", style: TextStyle(color: Colors.white, fontSize: 16)),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}

