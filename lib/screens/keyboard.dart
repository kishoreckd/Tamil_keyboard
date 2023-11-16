import 'package:flutter/material.dart';
import 'package:keyboard_tamil/screens/constant.dart';
import 'package:keyboard_tamil/screens/widget/keyboardkey.dart';

// ignore_for_file: library_private_types_in_public_api

// ignore_for_file: unnecessary_type_check

class TamilKeyboard extends StatefulWidget {
  const TamilKeyboard({super.key});

  @override
  _TamilKeyboardState createState() => _TamilKeyboardState();
}

class _TamilKeyboardState extends State<TamilKeyboard> {
  late String text;
  List? textStore;

  @override
  void initState() {
    super.initState();
    text = '';
  }

  keyPress(val) {
    setState(() {
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
        if (val == "ெ" || val == "ே" || val == "ை") {}
        if (meiEzhuthukal.any((e) => e.contains(text[text.length - 1]))) {
          text += val;
        }
        if (tamilSymbols.any((e) => e.contains(text[text.length - 1]))) {}
      } else {
        // text += val;
      }
    });
  }

  onBackspacePress(val) {
    setState(() {
      text = text.substring(0, text.length - 1);
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
                  onTap: y is Widget ? onBackspacePress : keyPress,
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
                  onTap: y is Widget ? onBackspacePress : keyPress,
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
                  onTap: y is Widget ? onBackspacePress : keyPress,
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
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              renderText(),
              Container(
                height: screenHeight * 0.37,
                decoration: const BoxDecoration(color: Color(0XFF5B5D72)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color(0xFF747794),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Container(
                                      width: 30 * fem,
                                      height: 30 * fem,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              159, 227, 227, 235),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: const Icon(
                                        Icons.emoji_emotions_outlined,
                                        size: 18,
                                      )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            159, 227, 227, 235),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    width: 30 * fem,
                                    height: 30 * fem,
                                    child: const Icon(
                                      Icons.edit_document,
                                      size: 18,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            159, 227, 227, 235),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    width: 30 * fem,
                                    height: 30 * fem,
                                    child: const Icon(
                                      Icons.keyboard_voice,
                                      size: 18,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            159, 227, 227, 235),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    width: 30 * fem,
                                    height: 30 * fem,
                                    child:
                                        const Icon(Icons.settings, size: 18)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              159, 227, 227, 235),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      width: 30 * fem,
                                      height: 30 * fem,
                                      child: const Icon(
                                        Icons.more_horiz,
                                        size: 18,
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                    width: screenWidth * 0.25,
                                    child: Column(
                                      children: [...renderKeyboard()],
                                    )),
                                SizedBox(
                                    width: screenWidth * 0.17,
                                    child: Column(
                                      children: [...renderKeyboard2()],
                                    )),
                                SizedBox(
                                    width: screenWidth * 0.50,
                                    child: Column(
                                      children: [...renderKeyboard3()],
                                    )),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal:4.0),
                              child: SizedBox(
                                  child: Row(
                                children: [
                                  KeyboardKey(
                                      label: '?123',
                                      onTap: '?123' is Widget
                                          ? onBackspacePress
                                          : keyPress,
                                      value: '?123'),
                                  KeyboardKey(
                                      label: 'ஃ',
                                      onTap: 'ஃ' is Widget
                                          ? onBackspacePress
                                          : keyPress,
                                      value: 'ஃ'),
                                  Spacebar(
                                      label: ' ',
                                      onTap: ' ' is Widget
                                          ? onBackspacePress
                                          : keyPress,
                                      value: ' '),
                                  KeyboardKey(
                                      label: '்',
                                      onTap: '்' is Widget
                                          ? onBackspacePress
                                          : keyPress,
                                      value: '்'),
                                  KeyboardKey(
                                      label: '.',
                                      onTap: '.' is Widget
                                          ? onBackspacePress
                                          : keyPress,
                                      value: '.'),
                                  KeyboardKey(
                                      label: const Icon(
                                        Icons.keyboard_backspace,
                                        color: Colors.white,
                                      ),
                                      onTap: const Icon(Icons.keyboard_backspace)
                                              is Widget
                                          ? onBackspacePress
                                          : keyPress,
                                      value:
                                          const Icon(Icons.keyboard_backspace)),
                                  KeyboardKey(
                                      label: const Icon(
                                        Icons.backspace,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      onTap: const Icon(Icons.backspace) is Widget
                                          ? onBackspacePress
                                          : keyPress,
                                      value: const Icon(Icons.backspace)),
                                ],
                              )),
                            ),
                          ],
                        ),
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

//  SvgPicture.string(
//                                 logo,
//                                 allowDrawingOutsideViewBox: true,
//                                 fit: BoxFit.fill,
//                               )
