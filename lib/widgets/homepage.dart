import 'dart:async';
import 'package:flutter/material.dart';
import 'package:keyboard_tamil/widgets/constant.dart';
import 'package:keyboard_tamil/widgets/keyboardkey.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  OverlayEntry? overlayEntry;
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0XFF080808),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0XFF080808),
        title: const Text(
          'தமிழ் விசைப்பலகை',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(
                        0XFF202020), // Set the background color to white
                  ),
                  height: screenHeight * 0.5,
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: TextField(
                      showCursor: true,
                      readOnly: true,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'எழுதுக....',
                          hintStyle: TextStyle(color: Colors.white38)),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      controller: _textController,
                      onTap: () {
                        _showCustomKeyboard(context);
                      },
                    ),
                  ),
                ),
              ),
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

    Overlay.of(context).insert(overlayEntry!);
  }

  @override
  void dispose() {
    overlayEntry?.remove();
    super.dispose();
  }
}

class CustomKeyboard extends StatefulWidget {
  const CustomKeyboard(
      {super.key, required this.onKeyPressed, required this.textController});

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

  // keyPress(val) {
  //   setState(() {
  //     final currentCursorPosition = widget.textController.selection.start;
  //     void replaceTextRange(String newText) {
  //       widget.textController.text = widget.textController.text.replaceRange(
  //         currentCursorPosition,
  //         currentCursorPosition,
  //         newText,
  //       );
  //     }

  //     String getPreviousCharacter() {
  //       if (currentCursorPosition > 0) {
  //         return widget.textController.text[currentCursorPosition - 1];
  //       }
  //       return '';
  //     }

  //     bool isTamilSymbol(String character) {
  //       return tamilSymbols.any((e) => e.contains(character));
  //     }

  //     num computeNewCursorPosition() {
  //       if (val == "ெ" || val == "ே" || val == "ை") {
  //         return currentCursorPosition;
  //       }
  //       if (!isTamilSymbol(val)) {
  //         return currentCursorPosition + val.length;
  //       } else {
  //         // Check if the previous character is also a Tamil symbol

  //         bool previousIsTamilSymbol = isTamilSymbol(getPreviousCharacter());

  //         // If the previous character is not a Tamil symbol, or if it's the first Tamil symbol in a row, increase cursor position
  //         if (!previousIsTamilSymbol) {
  //           return currentCursorPosition + val.length;
  //         }
  //       }
  //       return currentCursorPosition;
  //     }

  //     if (val == "்") {
  //       if (meiEzhuthukal.any((e) => e.contains(getPreviousCharacter()))) {
  //         replaceTextRange(val);
  //       }
  //     }

  //     if (val == ' ' || val == '\n' || val == 'ஃ' || val == '.') {
  //       replaceTextRange(val);
  //     }

  //     if (uyirEzhuthukal.any((e) => e.contains(val))) {
  //       textStore = [];
  //       replaceTextRange(val);
  //     }

  //     if (meiEzhuthukal.any((e) => e.contains(val))) {
  //       if (textStore?.length == 1) {
  //         // Store the current cursor position before making any changes
  //         int initialCursorPosition = currentCursorPosition;

  //         textStore?.add(val);
  //         replaceTextRange('${textStore?[1]}${textStore?[0]}');
  //         textStore = [];

  //         // Set the cursor position back to the initial position
  //         final newCursorPosition = TextPosition(offset: initialCursorPosition);
  //         widget.textController.selection =
  //             TextSelection.fromPosition(newCursorPosition);

  //         return;
  //       } else {
  //         textStore = [];
  //         replaceTextRange(val);
  //       }
  //     }

  //     if (isTamilSymbol(val)) {
  //       textStore = [];
  //       if (val == "ா") {
  //         if (getPreviousCharacter() == "ெ" || getPreviousCharacter() == "ே") {
  //           replaceTextRange(val);
  //         }
  //       }
  //       if (val == "ெ" || val == "ே" || val == "ை") {
  //         textStore = [val];
  //       }
  //       if (val == "ி" ||
  //           val == "ீ" ||
  //           val == "ு" ||
  //           val == "ூ" ||
  //           val == "ா") {
  //         if (meiEzhuthukal.any((e) => e.contains(getPreviousCharacter()))) {
  //           replaceTextRange(val);
  //         }
  //       }
  //     }

  //     final newCursorPosition = computeNewCursorPosition();

  //     // Ensure the new cursor position is within the valid range
  //     final newPosition = TextPosition(
  //       offset: newCursorPosition.clamp(
  //         0,
  //         widget.textController.text.length.toInt(),
  //       ) as int,
  //     );
  //     widget.textController.selection = TextSelection.fromPosition(newPosition);

  //     widget.onKeyPressed(widget.textController.text);
  //   });
  // }

  keyPress(val) {
    setState(() {
      final currentCursorPosition = widget.textController.selection.start;

      void replaceTextRange(String newText) {
        widget.textController.text = widget.textController.text.replaceRange(
          currentCursorPosition,
          currentCursorPosition,
          newText,
        );
      }

      String getPreviousCharacter() {
        if (currentCursorPosition > 0) {
          return widget.textController.text[currentCursorPosition - 1];
        }
        return '';
      }

      bool isTamilSymbol(String character) {
        return tamilSymbols.any((e) => e.contains(character));
      }

      num computeNewCursorPosition() {
        if (val == "ெ" || val == "ே" || val == "ை" || val == "ா") {
          return currentCursorPosition;
        }

        if (!isTamilSymbol(val)) {
          return currentCursorPosition + val.length;
        }

        // Check if the previous character is Uyirezhuthu or a Tamil symbol
        bool previousIsUyirezhuthu =
            uyirEzhuthukal.any((e) => e.contains(getPreviousCharacter()));
        bool previousIsTamilSymbol = isTamilSymbol(getPreviousCharacter());

        // If the previous character is neither Uyirezhuthu nor a Tamil symbol, increase cursor position
        if (!previousIsUyirezhuthu && !previousIsTamilSymbol) {
          return currentCursorPosition + val.length;
        }

        return currentCursorPosition;
      }

      if (val == "்") {
        if (meiEzhuthukal.any((e) => e.contains(getPreviousCharacter()))) {
          replaceTextRange(val);
        }
      }

      if (val == ' ' || val == '\n' || val == 'ஃ' || val == '.') {
        replaceTextRange(val);
      }

      if (uyirEzhuthukal.any((e) => e.contains(val))) {
        replaceTextRange(val);
      }

      if (meiEzhuthukal.any((e) => e.contains(val))) {
        if (textStore?.length == 1) {
          // Store the current cursor position before making any changes
          int initialCursorPosition = currentCursorPosition;

          // Check if the previous character is Uyirezhuthu or a Tamil symbol
          bool previousIsUyirezhuthu =
              uyirEzhuthukal.any((e) => e.contains(getPreviousCharacter()));
          bool previousIsTamilSymbol = isTamilSymbol(getPreviousCharacter());

          // If the previous character is neither Uyirezhuthu nor a Tamil symbol, increase cursor position
          if (!previousIsUyirezhuthu && !previousIsTamilSymbol) {
            initialCursorPosition += textStore!.length;
          }

          textStore?.add(val);
          replaceTextRange('${textStore?[1]}${textStore?[0]}');
          textStore = [];

          // Set the cursor position back to the initial position
          final newCursorPosition =
              TextPosition(offset: initialCursorPosition + 1);
          widget.textController.selection =
              TextSelection.fromPosition(newCursorPosition);

          return;
        } else {
          textStore = [];
          replaceTextRange(val);
        }
      }

      if (isTamilSymbol(val)) {
        textStore = [];
        if (val == "ா") {
          if (getPreviousCharacter() == "ெ" || getPreviousCharacter() == "ே") {
            replaceTextRange(val);
          }
        }
        if (val == "ெ" || val == "ே" || val == "ை") {
          textStore = [val];
        }
        if (val == "ி" ||
            val == "ீ" ||
            val == "ு" ||
            val == "ூ" ||
            val == "ா") {
          if (meiEzhuthukal.any((e) => e.contains(getPreviousCharacter()))) {
            replaceTextRange(val);
          }
        }
      }

      final newCursorPosition = computeNewCursorPosition();

      final newPosition = TextPosition(
        offset: newCursorPosition.clamp(
          0,
          widget.textController.text.length.toInt(),
        ) as int,
      );
      widget.textController.selection = TextSelection.fromPosition(newPosition);

      widget.onKeyPressed(widget.textController.text);
    });
  }

  onBackspacePress() {
    setState(() {
      if (widget.textController.text.isNotEmpty) {
        final currentSelection = widget.textController.selection;
        if (currentSelection.start == currentSelection.end) {
          if (currentSelection.start > 0) {
            final previousChar =
                widget.textController.text[currentSelection.start - 1];
            if (tamilSymbols.any((e) => e.contains(previousChar))) {
              // If the previous letter contains Tamil symbols, remove 2 characters
              widget.textController.text = widget.textController.text
                      .substring(0, currentSelection.start - 2) +
                  widget.textController.text.substring(currentSelection.start);
              widget.textController.selection = TextSelection.fromPosition(
                TextPosition(offset: currentSelection.start - 2),
              );
            } else {
              // If the previous letter does not contain Tamil symbols, remove 1 character
              widget.textController.text = widget.textController.text
                      .substring(0, currentSelection.start - 1) +
                  widget.textController.text.substring(currentSelection.start);
              widget.textController.selection = TextSelection.fromPosition(
                TextPosition(offset: currentSelection.start - 1),
              );
            }
          }
        } else {
          widget.textController.text = widget.textController.text.replaceRange(
            currentSelection.start,
            currentSelection.end,
            '',
          );
        }
      }
    });
  }

  onBackspacePressLong() {
    setState(() {
      if (widget.textController.text.isNotEmpty) {
        final currentSelection = widget.textController.selection;
        if (currentSelection.start == currentSelection.end) {
          if (currentSelection.start > 0) {
            final previousChar =
                widget.textController.text[currentSelection.start - 1];
            if (tamilSymbols.any((e) => e.contains(previousChar))) {
              // If the previous letter contains Tamil symbols, remove 2 characters
              widget.textController.text = widget.textController.text
                      .substring(0, currentSelection.start - 2) +
                  widget.textController.text.substring(currentSelection.start);
              widget.textController.selection = TextSelection.fromPosition(
                TextPosition(offset: currentSelection.start - 2),
              );
            } else {
              // If the previous letter does not contain Tamil symbols, remove 1 character
              widget.textController.text = widget.textController.text
                      .substring(0, currentSelection.start - 1) +
                  widget.textController.text.substring(currentSelection.start);
              widget.textController.selection = TextSelection.fromPosition(
                TextPosition(offset: currentSelection.start - 1),
              );
            }
          }
        } else {
          widget.textController.text = widget.textController.text.replaceRange(
            currentSelection.start,
            currentSelection.end,
            '',
          );
        }
      }
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
                  // KeyboardKey(label: '.', onTap: keyPress, value: '.'),
                  KeyboardKey(
                    label: const Icon(
                      Icons.keyboard_return_sharp,
                      color: Colors.white,
                      size: 16,
                    ),
                    onTap: keyPress,
                    value: '\n',
                  ),
                  GestureDetector(
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
                            onBackspacePressLong();
                          });
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 3,
                        horizontal: 4,
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            onBackspacePress();
                          });
                        },
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
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
