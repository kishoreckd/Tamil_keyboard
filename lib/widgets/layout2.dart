import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constant/constant_keys.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keyboard_tamil/widgets/keyboardkey.dart';

class Layout2 extends ConsumerStatefulWidget {
  const Layout2(
      {super.key,
      required this.onKeyPressed,
      required this.textController,
      required this.isdarkmode});

  final Function(String) onKeyPressed;
  final TextEditingController textController;
  final bool isdarkmode;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Layout2State();
}

class _Layout2State extends ConsumerState<Layout2> {
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
                  isdarkmode: widget.isdarkmode,
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
                  isdarkmode: widget.isdarkmode,
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
    return meiEzhuthukal2
        .map(
          (x) => Row(
            children: x.map((y) {
              return Expanded(
                child: KeyboardKeys(
                  isdarkmode: widget.isdarkmode,
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  EndKey(
                      label: 'ஃ',
                      onTap: keyPress,
                      value: 'ஃ',
                      isdarkmode: widget.isdarkmode),
                  EndKey(
                      label: ',',
                      onTap: keyPress,
                      value: ',',
                      isdarkmode: widget.isdarkmode),
                  Spacebar(
                    label: ' ',
                    onTap: keyPress,
                    value: ' ',
                    isdarkmode: widget.isdarkmode,
                  ),
                  EndKey(
                      label: 'க்ஷ',
                      onTap: keyPress,
                      value: 'க்ஷ',
                      isdarkmode: widget.isdarkmode),
                  EndKey(
                      label: '.',
                      onTap: keyPress,
                      value: '.',
                      isdarkmode: widget.isdarkmode),
                  EndKey(
                    isdarkmode: widget.isdarkmode,
                    label: Icon(
                      Icons.keyboard_return_sharp,
                      color: widget.isdarkmode
                          ? const Color(0XFFE9ECF1)
                          : const Color(0XFF0d0c1d),
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
                        splashColor: widget.isdarkmode
                            ? const Color.fromARGB(255, 120, 120, 120)
                            : const Color.fromARGB(255, 131, 196, 224),
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
                            color: widget.isdarkmode
                                ? const Color(0xFF313131)
                                : const Color(0XFFFFFFFF),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Icon(
                            Icons.backspace,
                            size: 16,
                            color: widget.isdarkmode
                                ? const Color(0XFFE9ECF1)
                                : const Color(0XFF534D73),
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
