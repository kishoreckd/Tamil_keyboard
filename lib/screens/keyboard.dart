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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    TextEditingController _titlecontroller = TextEditingController();
    final TextEditingController _contentcontroller = TextEditingController();

    FocusNode _focusNode1 = FocusNode();
    FocusNode _focusNode2 = FocusNode();

    @override
    void dispose() {
      _focusNode1.dispose();
      _focusNode2.dispose();
      super.dispose();
    }

    void _handleFocusChange() {
      if (_focusNode1.hasFocus) {
        print('1');
        _titlecontroller.text = text;
      } else if (_focusNode2.hasFocus) {
        _contentcontroller.text = text;
      }
    }

    // @override
    // void initState() {
    //   super.initState();
    //   _focusNode1.addListener(() {
    //     if (_focusNode1.hasFocus) {
    //       print('TextField 1 is selected');
    //     }
    //   });

    //   _focusNode2.addListener(() {
    //     if (_focusNode2.hasFocus) {
    //       print('TextField 2 is selected');
    //     }
    //   });
    // }

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    TextField(
                      onTap: _handleFocusChange,
                      // controller: _titlecontroller,
                      focusNode: _focusNode1,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'தலைப்பு',
                        hintStyle: TextStyle(
                          fontSize: 18,
                          letterSpacing: 1,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          color: Color(
                            0xFFC3C3C3,
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      color: Color(0xFFEBE9F0),
                    ),
                    TextField(
                      onTap: _handleFocusChange,
                      // controller: _contentcontroller,
                      focusNode: _focusNode2,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Add Title',
                        hintStyle: TextStyle(
                          fontSize: 18,
                          letterSpacing: 1,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          color: Color(
                            0xFFC3C3C3,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // renderText(),
              Ink(
                height: 250,
                decoration: const BoxDecoration(color: Color(0XFF202020)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                  width: screenWidth * 0.26,
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: SizedBox(
                                child: Row(
                              children: [
                                KeyboardKey(
                                    label: '?123', onTap: keyPress, value: ''),
                                KeyboardKey(
                                    label: 'ஃ', onTap: keyPress, value: 'ஃ'),
                                Spacebar(
                                    label: ' ', onTap: keyPress, value: ' '),
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
                                        text =
                                            text.substring(0, text.length - 1);
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
                                          text = text.substring(
                                              0, text.length - 1);
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
                          ),
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
