import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:keyboard_tamil/widgets/Homepage.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
// import 'package:keyboard_tamil/screens/keyboard.dart';

// ignore_for_file: avoid_print

// void main() => runApp(const MaterialApp(home: TamilKeyboard()));

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyHomePage(),
  ));
}



// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   List<String> reactions = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Reactions App'),
//       ),
//       body: Center(
//         child: Container(
//           width: double.infinity,
//           height: 200,
//           color: Colors.grey,
//           child: ListView(
//             scrollDirection: Axis.horizontal,
//             children: [
//               buildReactionWidget('👍', 'Like'),
//               buildReactionWidget('❤️', 'Love'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildReactionWidget(String emoji, String label) {
//     return Dismissible(
//       key: Key(label),
//       onDismissed: (direction) {
//         showReaction(emoji, label);
//       },
//       background: Container(
//         color: Colors.green,
//         padding: EdgeInsets.symmetric(horizontal: 16),
//         alignment: Alignment.centerLeft,
//         child: Icon(Icons.thumb_up, color: Colors.white),
//       ),
//       secondaryBackground: Container(
//         color: Colors.red,
//         padding: EdgeInsets.symmetric(horizontal: 16),
//         alignment: Alignment.centerRight,
//         child: Icon(Icons.favorite, color: Colors.white),
//       ),
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 8),
//         padding: EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: Colors.blue,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               emoji,
//               style: TextStyle(fontSize: 30, color: Colors.white),
//             ),
//             SizedBox(height: 8),
//             Text(
//               label,
//               style: TextStyle(color: Colors.white),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void showReaction(String emoji, String label) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Row(
//           children: [
//             Text(label),
//             SizedBox(width: 8),
//             Text(emoji),
//           ],
//         ),
//       ),
//     );
//   }
// }
