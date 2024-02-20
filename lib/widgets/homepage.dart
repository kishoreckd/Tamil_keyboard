import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../constant/webviewscreen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_tamil/constant/svgicons.dart';
import 'package:keyboard_tamil/widgets/helpscreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keyboard_tamil/widgets/keyboardkey.dart';
import 'package:keyboard_tamil/constant/constant_keys.dart';
// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
// ignore_for_file: file_names

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<MyHomePage> {
  OverlayEntry? overlayEntry;
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0XFF080808),
      appBar: AppBar(
        backgroundColor: const Color(0XFF080808),
        title: const Text(
          'தமிழ் விசைப்பலகை',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: SvgPicture.string(feedbackIcon),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const WebViewScreen(
                    name: 'Feedback',
                    url:
                        'https://docs.google.com/forms/d/e/1FAIpQLSfXX2weStTmlXkzO8Iwi3vr4MgIK8-eGBmQCSzztbZle3SiXg/viewform'),
              ));
            },
          ),
          // IconButton(
          //   icon: SvgPicture.string(helpIcon),
          //   onPressed: () {
          //     Navigator.of(context).push(MaterialPageRoute(
          //       builder: (context) =>
          //           const HelpScreen(), // Replace with your HelpScreen widget
          //     ));
          //   },
          // ),
        ],
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      onTap: () {},
                    ),
                  ),
                ),
              ),
              Ink(
                decoration: const BoxDecoration(color: Color(0XFF202020)),
                child: CustomKeyboard(
                  onKeyPressed: (String value) {
                    // Handle key presses
                  },
                  textController: _textController,
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
              onKeyPressed: (String value) {},
              textController: _textController,
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

class CustomKeyboard extends ConsumerStatefulWidget {
  const CustomKeyboard(
      {super.key, required this.onKeyPressed, required this.textController});

  final Function(String) onKeyPressed;
  final TextEditingController textController;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomKeyboardState();
}

class _CustomKeyboardState extends ConsumerState<CustomKeyboard> {
  late String text;

  List? textStore;
  String? textSt;

  Timer? longPressTimer;

  @override
  void initState() {
    super.initState();
    text = '';
  }

  keyPress(val) {
    ref.read(symbolsNameProvider.notifier).state = '';

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
        bool previousIsMei =
            meiEzhuthukal.any((e) => e.contains(getPreviousCharacter()));
        // Check if the previous character is Uyirezhuthu or a Tamil symbol
        bool previousIsUyirezhuthu =
            uyirEzhuthukal.any((e) => e.contains(getPreviousCharacter()));
        bool previousIsTamilSymbol = isTamilSymbol(getPreviousCharacter());
        if (val == "ா") {
          if (previousIsMei ||
              previousIsTamilSymbol && getPreviousCharacter() != "ா") {
            return currentCursorPosition + 1;
          }
        }

        if (val == "ெ" || val == "ே" || val == "ை") {
          return currentCursorPosition;
        }

        if (!isTamilSymbol(val)) {
          return currentCursorPosition + val.length;
        }

        // If the previous character is neither Uyirezhuthu nor a Tamil symbol, increase cursor position
        if (!previousIsUyirezhuthu && !previousIsTamilSymbol) {
          return currentCursorPosition + val.length;
        }

        if (meiEzhuthukal.any((e) => e.contains(val))) {
          // Handle consecutive Meiezhuthu characters
          return currentCursorPosition + val.length;
        }

        return currentCursorPosition;
      }

      if (val == "்") {
        if (meiEzhuthukal.any((e) => e.contains(getPreviousCharacter())) &&
            getPreviousCharacter() != "்") {
          replaceTextRange(val);
        }
      }

      if (val == ' ' || val == '\n' || val == 'ஃ' || val == '.') {
        replaceTextRange(val);
      }

      if (uyirEzhuthukal.any((e) => e.contains(val))) {
        textStore = [];
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
          if (previousIsTamilSymbol == true) {
            previousIsTamilSymbol = !previousIsTamilSymbol;
          }
          // If the previous character is neither Uyirezhuthu nor a Tamil symbol, increase cursor position
          if (!previousIsUyirezhuthu && !previousIsTamilSymbol) {
            initialCursorPosition += textStore!.length;
          }

          textStore?.add(val);
          replaceTextRange('${textStore?[1]}${textStore?[0]}');
          textStore = [];
          ref.read(symbolsNameProvider.notifier).state = '';
          // Set the cursor position back to the initial position
          final newCursorPosition =
              TextPosition(offset: initialCursorPosition + 1);
          widget.textController.selection =
              TextSelection.fromPosition(newCursorPosition);

          if (previousIsUyirezhuthu) {
            // If the previous letter is Uyirezhuthu, adjust the cursor position
            widget.textController.selection = TextSelection.fromPosition(
                TextPosition(offset: newCursorPosition.offset + 1));
          } else {
            widget.textController.selection =
                TextSelection.fromPosition(newCursorPosition);
          }

          return;
        } else {
          textStore = [];
          replaceTextRange(val);
        }
      }

      if (isTamilSymbol(val)) {
        textStore = [];
        if (val == "ா") {
          if (getPreviousCharacter() == "ெ" ||
              getPreviousCharacter() == "ே" && getPreviousCharacter() != "ா") {
            currentCursorPosition + 1;
            replaceTextRange(val);
          }
        }
        if (val == "ெ" || val == "ே" || val == "ை") {
          textStore = [val];
          ref.read(symbolsNameProvider.notifier).state = val;
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
    SystemSound.play(SystemSoundType.click);

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
                child: KeyboardKeys(
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
                child: SymbolsKeyboardKey(
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
                child: KeyboardKeys(
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
    final isMobile = screenWidth < 600;
    // final padding = isMobile ? 1.8 : 3.6;
    // final height = isMobile ? 40.0 : MediaQuery.of(context).size.height * 0.055;
    final width = isMobile ? 36.0 : screenWidth * 0.09;
    return Ink(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
            SizedBox(
              child: Row(
                children: [
                  EndKey(label: 'ஃ', onTap: keyPress, value: 'ஃ'),
                  EndKey(label: ',', onTap: keyPress, value: ','),
                  Spacebar(label: ' ', onTap: keyPress, value: ' '),
                  EndKey(label: '்', onTap: keyPress, value: '்'),
                  EndKey(label: '.', onTap: keyPress, value: '.'),
                  EndKey(
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
                      padding: EdgeInsets.symmetric(
                        vertical: 3,
                        horizontal: screenWidth > 600
                            ? screenWidth * 0.01
                            : screenWidth * 0.005,
                        // Adjust the padding based on screen width
                      ),
                      child: InkWell(
                        splashColor: const Color.fromARGB(255, 120, 120, 120),
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
                          width: width,
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
          ],
        ),
      ),
    );
  }
}
