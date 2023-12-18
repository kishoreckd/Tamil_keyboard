import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:keyboard_tamil/screens/keyboard.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MaterialApp(
//     home: TamilKeyboard(),
//   ));
// }

// class CustomKeyboard extends StatelessWidget {
//   final Function(String) onKeyPressed;

//   CustomKeyboard({required this.onKeyPressed});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.grey[200],
//       child: Column(
//         children: [
//           buildRow(['1', '2', '3']),
//           buildRow(['4', '5', '6']),
//           buildRow(['7', '8', '9']),
//           buildRow(['0']),
//         ],
//       ),
//     );
//   }

//   Widget buildRow(List<String> keys) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: keys
//           .map(
//             (key) => ElevatedButton(
//               onPressed: () {
//                 onKeyPressed(key);
//               },
//               child: Text(key),
//             ),
//           )
//           .toList(),
//     );
//   }
// }

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
//   TextEditingController _textController = TextEditingController();

//   void handleKeyPressed(String key) {
//     setState(() {
//       _textController.text += key;
//     });
//   }

//   void clearText() {
//     setState(() {
//       _textController.clear();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Custom Keyboard Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _textController,
//               readOnly: true,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: 'Tap here to show custom keyboard',
//               ),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 clearText();
//               },
//               child: Text('Clear'),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _showCustomKeyboard(context);
//         },
//         child: Icon(Icons.keyboard),
//       ),
//     );
//   }

//   void _showCustomKeyboard(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (BuildContext context) {
//         return SingleChildScrollView(
//           child: Container(
//             padding: EdgeInsets.only(
//               bottom: MediaQuery.of(context).viewInsets.bottom,
//             ),
//             child: CustomKeyboard(onKeyPressed: handleKeyPressed),
//           ),
//         );
//       },
//     );
//   }
// }


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  OverlayEntry? overlayEntry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Keyboard Example'),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Column(
            children: [
              TextField(
                onTap: () {
                  _showCustomKeyboard(context);
                },
              ),
              // Other widgets in your UI
            ],
          );
        },
      ),
    );
  }

  void _showCustomKeyboard(BuildContext context) {
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Material(
          child: Container(
            color: Colors.white,
            child: CustomKeyboard(
              onKeyPressed: (String value) {
                // Handle key presses
              },
            ),
          ),
        ),
      ),
    );

    Overlay.of(context)?.insert(overlayEntry!);
  }

  @override
  void dispose() {
    overlayEntry?.remove();
    super.dispose();
  }
}


class CustomKeyboard extends StatelessWidget {
  final Function(String) onKeyPressed;

  CustomKeyboard({required this.onKeyPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Column(
        children: [
          buildRow(['1', '2', '3']),
          buildRow(['4', '5', '6']),
          buildRow(['7', '8', '9']),
          buildRow(['0']),
        ],
      ),
    );
  }

  Widget buildRow(List<String> keys) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: keys
          .map(
            (key) => ElevatedButton(
              onPressed: () {
                onKeyPressed(key);
              },
              child: Text(key),
            ),
          )
          .toList(),
    );
  }
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

// class MyHomePage extends StatelessWidget {
//   final FocusNode _focusNode = FocusNode();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Custom Keyboard Example'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: TextField(
//             focusNode: _focusNode,
//             decoration: InputDecoration(
//               border: OutlineInputBorder(),
//               hintText: 'Tap here to show custom keyboard',
//             ),
//             onTap: () {
//               // Show custom keyboard when the text field is tapped
//               _showCustomKeyboard(context);
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   void _showCustomKeyboard(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (BuildContext context) {
//         return Padding(
//           padding: EdgeInsets.only(
//             bottom: MediaQuery.of(context).viewInsets.bottom,
//           ),
//           child: Container(
//             child: ElevatedButton(onPressed: (){}, child: Text('okie')),
//           ),
//         );
//       },
//     );
//   }
// }
