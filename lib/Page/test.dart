// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class Test extends StatefulWidget {
//   const Test({Key? key}) : super(key: key);
//
//   @override
//   State<Test> createState() => _TestState();
// }
//
// class _TestState extends State<Test> {
//   final prefs = SharAedPreferences.getInstance();
//   final id= prefs.setInt('counter', 10);
//
//
//   @override
//   void initState() {
//     super.initState();
//     _counter = _prefs.then((SharedPreferences prefs) {
//       return prefs.getInt('counter') ?? 0;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('SharedPreferences Demo'),
//       ),
//       body: Center(
//           child: FutureBuilder<int>(
//               future: _counter,
//               builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
//                 switch (snapshot.connectionState) {
//                   case ConnectionState.waiting:
//                     return const CircularProgressIndicator();
//                   default:
//                     if (snapshot.hasError) {
//                       return Text('Error: ${snapshot.error}');
//                     } else {
//                       return Text(
//                         'Button tapped ${snapshot.data} time${snapshot.data == 1 ? '' : 's'}.\n\n'
//                             'This should persist across restarts.',
//                       );
//                     }
//                 }
//               })),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
