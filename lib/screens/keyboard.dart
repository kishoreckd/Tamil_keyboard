import 'dart:async';
import 'package:flutter/material.dart';
import 'package:keyboard_tamil/screens/constant.dart';
import 'package:keyboard_tamil/screens/widget/keyboardkey.dart';

class TamilKeyboard extends StatefulWidget {
  const TamilKeyboard({super.key});

  @override
  TamilKeyboardState createState() => TamilKeyboardState();
}

class TamilKeyboardState extends State<TamilKeyboard> {
  late String text;
  List? textStore;
  Timer? longPressTimer; // Add this line

  @override
  void initState() {
    super.initState();
    text = '';
  }

  keyPress(val) {
    setState(() {
      if (val == ' ') {
        text += val;
      }
      if (val == '\n') {
        text += val;
      }
      if (uyirEzhuthukal.any((e) => e.contains(val))) {
        textStore = [];

        text += val;
      }
      if (val == "்") {
        if (meiEzhuthukal.any((e) => e.contains(text[text.length - 1]))) {
          text += val;
        }
      }
      if (val == "ஃ") {
        text += val;
      }

      ///Uyir mei eluthu logics
      if (meiEzhuthukal.any((e) => e.contains(val))) {
        if (textStore?.length == 1) {
          textStore?.add(val);
          text += textStore?[1] + textStore?[0];
          textStore = [];
          return;
        } else {
          textStore = [];

          text += val;
        }
      }

      if (tamilSymbols.any((e) => e.contains(val))) {
        textStore = [];

        if (val == "ா") {
          if (text[text.length - 1] == "ெ" || text[text.length - 1] == "ே") {
            text += val;
          }
        }
        if (val == "ெ" || val == "ே" || val == "ை") {
          textStore = [val];
        }
        if (meiEzhuthukal.any((e) => e.contains(text[text.length - 1]))) {
          if (val == "ி" ||
              val == "ீ" ||
              val == "ு" ||
              val == "ூ" ||
              val == "ா") {
            text += val;
          }
        }
        if (tamilSymbols.any((e) => e.contains(text[text.length - 1]))) {}
      }
    });
  }

  onBackspacePress(val) {
    setState(() {
      text = text.substring(0, text.length - 1);
    });
  }

  onBackspacePressLong(val) {
    longPressTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        text = text.substring(0, text.length - 1);
      });
    });
  }

  renderKeyboard() {
    return uyirEzhuthukal
        .map(
          (x) => Row(
            children: x.map((y) {
              // print(y);
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

  renderText() {
    return Expanded(
      child: Center(
        child: Text(
          text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              renderText(),
              Ink(
                height: 250,
                decoration: const BoxDecoration(color: Color(0XFF202020)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                  width: 110,
                                  child: Column(
                                    children: [...renderKeyboard()],
                                  )),
                              SizedBox(
                                  width: 80,
                                  child: Column(
                                    children: [...renderKeyboard2()],
                                  )),
                              SizedBox(
                                  width: 210,
                                  child: Column(
                                    children: [...renderKeyboard3()],
                                  )),
                            ],
                          ),
                          SizedBox(
                              child: Row(
                            children: [
                              KeyboardKey(
                                  label: '?123', onTap: keyPress, value: ''),
                              KeyboardKey(
                                  label: 'ஃ', onTap: keyPress, value: 'ஃ'),
                              Spacebar(label: ' ', onTap: keyPress, value: ' '),
                              KeyboardKey(
                                  label: '்', onTap: keyPress, value: '்'),
                              KeyboardKey(
                                  label: '.', onTap: keyPress, value: '.'),
                              KeyboardKey(
                                  label: const Icon(
                                    Icons.keyboard_return_sharp,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  onTap: keyPress,
                                  value: '\n'),
                              InkWell(
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      text = text.substring(0, text.length - 1);
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
                                        text =
                                            text.substring(0, text.length - 1);
                                      });
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 3, horizontal: 4),
                                    child: Ink(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF313131),
                                          borderRadius:
                                              BorderRadius.circular(7)),
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
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
