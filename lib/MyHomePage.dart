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
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isOpened = false;

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
              title: Text("Pointage"),
            ),
            body:
            themejolie(donner: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[


                FadeAnimation(1, Text("Bonjour Bienvenue dans l'Entreprise", style: TextStyle(color: Colors.white, fontSize: 40),)),
                SizedBox(
                  height: 10,
                ),
                FadeAnimation(1.3, Text("Welcome Back", style: TextStyle(color: Colors.white, fontSize: 18),)),
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
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 22.0,
                ),
                SizedBox(height: 16.0),
                Text(
                  "Hello, IKlass",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.home, size: 20.0, color: Colors.white),
            title: const Text("Pointage"),
            textColor: Colors.white,
            dense: true,
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder:
                  (context)=>Profile()));
            },
            leading: const Icon(Icons.account_circle,
                size: 20.0, color: Colors.white),
            title: const Text("Profile"),
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
                size: 20.0, color: Colors.white),
            title: const Text("Notification"),
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
            const Icon(Icons.security, size: 20.0, color: Colors.white),
            title: const Text("Demande Autorisation"),
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
            const Icon(Icons.security, size: 20.0, color: Colors.white),
            title: const Text("Liste des Autorisation"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {
    Navigator.push(context, MaterialPageRoute(builder:
    (context)=>Login()));

              Login().Deconnecter();
            },
            leading:
            const Icon(Icons.logout, size: 20.0, color: Colors.white),
            title: const Text("Deconexion"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}

