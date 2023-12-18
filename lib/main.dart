import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_tamil/screens/constant.dart';
import 'package:keyboard_tamil/screens/widget/keyboardkey.dart';
// ignore_for_file: duplicate_import

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MaterialApp(
//     home: TamilKeyboard(),
//   ));
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
  TextEditingController _textController = TextEditingController();

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
                controller: _textController, // Use the TextEditingController

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
          child: Ink(
            decoration: const BoxDecoration(color: Color(0XFF202020)),
            child: CustomKeyboard(
              onKeyPressed: (String value) {
                // Handle key presses
              },
              textController: _textController, // Use the TextEditingController
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

class CustomKeyboard extends StatefulWidget {
  const CustomKeyboard(
      {required this.onKeyPressed, required this.textController});

  final Function(String) onKeyPressed;
  final TextEditingController textController;

  @override
  State<CustomKeyboard> createState() => _CustomKeyboardState();
}

class _CustomKeyboardState extends State<CustomKeyboard> {
  late String text;

  List? textStore;

  Timer? longPressTimer;

  @override
  void initState() {
    super.initState();
    text = '';
  }

  keyPress(val) {
    setState(() {
      if (val == ' ') {
        widget.textController.text += val;
      }
      if (val == '\n') {
        widget.textController.text += val;
      }
      if (uyirEzhuthukal.any((e) => e.contains(val))) {
        textStore = [];
        widget.textController.text += val;
      }
      if (val == "்") {
        if (meiEzhuthukal.any((e) => e.contains(widget
            .textController.text[widget.textController.text.length - 1]))) {
          widget.textController.text += val;
        }
      }
      if (val == "ஃ") {
        widget.textController.text += val;
      }

      /// Uyir mei eluthu logics
      if (meiEzhuthukal.any((e) => e.contains(val))) {
        if (textStore?.length == 1) {
          textStore?.add(val);
          widget.textController.text += textStore?[1] + textStore?[0];
          textStore = [];
          return;
        } else {
          textStore = [];
          widget.textController.text += val;
        }
      }

      if (tamilSymbols.any((e) => e.contains(val))) {
        textStore = [];
        if (val == "ா") {
          if (widget.textController
                      .text[widget.textController.text.length - 1] ==
                  "ெ" ||
              widget.textController
                      .text[widget.textController.text.length - 1] ==
                  "ே") {
            widget.textController.text += val;
          }
        }
        if (val == "ெ" || val == "ே" || val == "ை") {
          textStore = [val];
        }
        if (meiEzhuthukal.any((e) => e.contains(widget
            .textController.text[widget.textController.text.length - 1]))) {
          if (val == "ி" ||
              val == "ீ" ||
              val == "ு" ||
              val == "ூ" ||
              val == "ா") {
            widget.textController.text += val;
          }
        }
        if (tamilSymbols.any((e) => e.contains(widget
            .textController.text[widget.textController.text.length - 1]))) {}
      }

      // Call onKeyPressed with the updated text
      widget.onKeyPressed(widget.textController.text);
    });
  }

  onBackspacePress() {
    setState(() {
      widget.textController.text = widget.textController.text.isNotEmpty
          ? widget.textController.text
              .substring(0, widget.textController.text.length - 1)
          : ''; // Update the text in the TextField
    });
  }

  onBackspacePressLong() {
    longPressTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        widget.textController.text = widget.textController.text.isNotEmpty
            ? widget.textController.text
                .substring(0, widget.textController.text.length - 1)
            : ''; // Update the text in the TextField
      });
    });
  }

  renderKeyboard() {
    return uyirEzhuthukal
        .map(
          (x) => Row(
            children: x.map((y) {
              return Expanded(
                child: KeyboardKey(
                  label: y,
                  onTap: keyPress,
                  value: y,
                ),
              );
            }).toList(),
          ),
        )
        .toList();
  }

  renderKeyboard2() {
    return tamilSymbols
        .map(
          (x) => Row(
            children: x.map((y) {
              return Expanded(
                child: KeyboardKey(
                  label: y,
                  onTap: keyPress,
                  value: y,
                ),
              );
            }).toList(),
          ),
        )
        .toList();
  }

  renderKeyboard3() {
    return meiEzhuthukal
        .map(
          (x) => Row(
            children: x.map((y) {
              return Expanded(
                child: KeyboardKey(
                  label: y,
                  onTap: keyPress,
                  value: y,
                ),
              );
            }).toList(),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Ink(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: screenWidth * 0.26,
                child: Column(
                  children: [...renderKeyboard()],
                ),
              ),
              SizedBox(
                width: screenWidth * 0.17,
                child: Column(
                  children: [...renderKeyboard2()],
                ),
              ),
              SizedBox(
                width: screenWidth * 0.50,
                child: Column(
                  children: [...renderKeyboard3()],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: SizedBox(
              child: Row(
                children: [
                  KeyboardKey(label: '?123', onTap: keyPress, value: ''),
                  KeyboardKey(label: 'ஃ', onTap: keyPress, value: 'ஃ'),
                  Spacebar(label: ' ', onTap: keyPress, value: ' '),
                  KeyboardKey(label: '்', onTap: keyPress, value: '்'),
                  KeyboardKey(label: '.', onTap: keyPress, value: '.'),
                  KeyboardKey(
                    label: const Icon(
                      Icons.keyboard_return_sharp,
                      color: Colors.white,
                      size: 16,
                    ),
                    onTap: keyPress,
                    value: '\n',
                  ),
                  InkWell(
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          onBackspacePress(); // Call onBackspacePress with an empty string
                        });
                      },
                      onLongPressUp: () {
                        setState(() {
                          longPressTimer?.cancel();
                        });
                      },
                      onLongPress: () {
                        longPressTimer = Timer.periodic(
                          const Duration(milliseconds: 100),
                          (timer) {
                            setState(() {
                              onBackspacePressLong(); // Call onBackspacePressLong with an empty string
                            });
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 3,
                          horizontal: 4,
                        ),
                        child: Ink(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFF313131),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: const Icon(
                            Icons.backspace,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
