import 'package:flutter/material.dart';
import 'package:keyboard_tamil/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// void main() => runApp(const MaterialApp(home: TamilKeyboard()));

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: Keyboard()));
}

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Bottom Navigation Bar',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: BottomNavigationDemo(),
//     );
//   }
// }

// class BottomNavigationDemo extends StatefulWidget {
//   @override
//   _BottomNavigationDemoState createState() => _BottomNavigationDemoState();
// }

// class _BottomNavigationDemoState extends State<BottomNavigationDemo> {
//   int _currentIndex = 0;

//   final List<Widget> _pages = [
//     Page(title: 'Home', color: Colors.blue),
//     Page(title: 'Favorites', color: Colors.green),
//     Page(title: 'Settings', color: Colors.orange),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Title'),
//       ),
//       body: AnimatedSwitcher(
//         duration: Duration(milliseconds: 500),
//         child: _pages[_currentIndex],
//       ),
//       bottomNavigationBar: BottomBarBubble(
//         selectedIndex: 0,
//         items: [
//           BottomBarItem(iconData: Icons.home),
//           BottomBarItem(iconData: Icons.chat),
//           BottomBarItem(iconData: Icons.notifications),
         
//         ],
//         onSelect: (index) {
//           // implement your select function here
//         },
//       ),
//     );
//   }
// }

// class Page extends StatelessWidget {
//   final String title;
//   final Color color;

//   Page({required this.title, required this.color, Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: color,
//       child: Center(
//         child: Text(
//           title,
//           style: TextStyle(fontSize: 24, color: Colors.white),
//         ),
//       ),
//     );
//   }
// }
