import 'package:flutter/material.dart';
/// *Normal backspace
//  onBackspacePress() {
//     setState(() {
//       if (widget.textController.text.isNotEmpty) {
//         final currentSelection = widget.textController.selection;
//         if (currentSelection.start == currentSelection.end) {
//           if (currentSelection.start > 0) {
//             widget.textController.text = widget.textController.text
//                     .substring(0, currentSelection.start - 1) +
//                 widget.textController.text.substring(currentSelection.start);
//             widget.textController.selection = TextSelection.fromPosition(
//               TextPosition(offset: currentSelection.start - 1),
//             );
//           }
//         } else {
//           widget.textController.text = widget.textController.text.replaceRange(
//             currentSelection.start,
//             currentSelection.end,
//             '',
//           );
//         }
//       }
//     });
//   }
// onBackspacePressLong() {
//   setState(() {
//     if (widget.textController.text.isNotEmpty) {
//       final currentSelection = widget.textController.selection;
//       if (currentSelection.start == currentSelection.end) {
//         if (currentSelection.start > 0) {
//           widget.textController.text = widget.textController.text
//                   .substring(0, currentSelection.start - 1) +
//               widget.textController.text.substring(currentSelection.start);
//           widget.textController.selection = TextSelection.fromPosition(
//             TextPosition(offset: currentSelection.start - 1),
//           );
//         }
//       } else {
//         widget.textController.text = widget.textController.text.replaceRange(
//           currentSelection.start,
//           currentSelection.end,
//           '',
//         );
//       }
//     }
//   });
// }


// void main() {
//   runApp(const NotesUI());
// }

// class NotesUI extends StatelessWidget {
//   const NotesUI({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Google Keep Notes',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Google Keep Notes'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () {
//               // Handle search action
//             },
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: 5, // Replace with your actual note count
//         itemBuilder: (context, index) {
//           return NoteCard(
//             title: 'Note $index',
//             content: 'This is the content of Note $index.',
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Handle add note action
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

// class NoteCard extends StatelessWidget {
//   final String title;
//   final String content;

//   NoteCard({required this.title, required this.content});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2.0,
//       margin: EdgeInsets.all(8.0),
//       child: InkWell(
//         onTap: () {
//           // Handle note tap action
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 18.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 8.0),
//               Text(
//                 content,
//                 style: TextStyle(fontSize: 16.0),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




// void main() {
//   runApp(const NotesUI());
// }

// class NotesUI extends StatelessWidget {
//   const NotesUI({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Google Keep Notes',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: const MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Google Keep Notes'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () {
//               // Handle search action
//             },
//           ),
//         ],
//       ),
//       body: GridView.builder(
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2, // Adjust the number of columns as needed
//           crossAxisSpacing: 8.0,
//           mainAxisSpacing: 8.0,
//         ),
//         itemCount: 10, // Replace with your actual note count
//         itemBuilder: (context, index) {
//           return NoteCard(
//             title: 'Note $index',
//             content: 'This is the content of Note $index.',
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Handle add note action
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

// class NoteCard extends StatelessWidget {
//   final String title;
//   final String content;

//   const NoteCard({super.key, required this.title, required this.content});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2.0,
//       child: InkWell(
//         onTap: () {
//           // Handle note tap action
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 18.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 8.0),
//               Text(
//                 content,
//                 style: const TextStyle(fontSize: 16.0),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
