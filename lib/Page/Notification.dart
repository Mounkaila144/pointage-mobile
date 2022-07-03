import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:mobile/Auth/services/Crud.dart';
import 'package:mobile/Page/Notificationoepage.dart';
import 'package:mobile/Page/theme.dart';

import '../service.dart';

class Notifationlist extends StatefulWidget {
  const Notifationlist({Key? key}) : super(key: key);

  @override
  State<Notifationlist> createState() => _NotifationlistState();
}

class _NotifationlistState extends State<Notifationlist> {
  List<Notificationpoint>? notif;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    notif = await Remote().getNotif();
    if (notif != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification reçu"),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.orange.shade700,
          Colors.orange.shade500,
          Colors.orange.shade300
        ])),
        child: Visibility(visible: isLoaded, child: builder(notif), replacement:
        themejolie(donner: Center(
          child: Column(
            children: [
              SizedBox(
                height: 200,
              ),
              LoadingJumpingLine.circle(
                borderColor: Colors.red,
                borderSize: 3.0,
                size: 200.0,
                backgroundColor: Colors.yellow,
                duration: Duration(milliseconds: 500),
              ),
            ],
          ),
        ),),
        ),
      ),
    );
  }
}

Widget builder(List<Notificationpoint>? notification) => ListView.builder(
      itemCount: notification?.length,
      itemBuilder: (context, index) {
        final notif = notification![index];
        return Column(
          children: [
            Card(
              color: Colors.orange.shade800,
              shadowColor: Colors.amber,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder:
                      (context)=>NotificationOnePage(id: notif.id)));
                },
                leading: CircleAvatar(child: Icon(Icons.notifications)),
                title: Text("Type  ${notif.type}"),
                subtitle: Text("Notification n°${notif.id}"),
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
