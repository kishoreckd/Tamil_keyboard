import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_tamil/widgets/constant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore_for_file: unused_local_variable

class KeyboardKeys extends ConsumerStatefulWidget {
  final dynamic label;
  final dynamic value;
  final ValueSetter<dynamic> onTap;

  const KeyboardKeys({
    super.key,
    @required this.label,
    required this.onTap,
    @required this.value,
  })  : assert(label != null),
        assert(value != null);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _KeyboardKeyState();
}

class _KeyboardKeyState extends ConsumerState<KeyboardKeys> {
  renderLabel() {
    if (widget.label is String) {
      return Center(
        child: Text(
          widget.label,
          style: const TextStyle(
              fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return widget.label;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final padding = isMobile ? 1.8 : 3.6;
    final height = isMobile ? 40.0 : MediaQuery.of(context).size.height * 0.055;
    final width = isMobile ? 40.0 : screenWidth * 0.09;
    // final height = 40.0;
    // final width = 40.0;
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 3,
            horizontal: padding,
          ),
          child: InkWell(
            splashColor: const Color.fromARGB(255, 120, 120, 120),
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            onTap: () {
              widget.onTap(widget.value);
              SystemSound.play(SystemSoundType.click);
            },
            child: Ink(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: const Color(0xFF313131),
                borderRadius: BorderRadius.circular(7),
              ),
              child: renderLabel(),
            ),
          ),
        ),
      ],
    );
  }
}

class SymbolsKeyboardKey extends ConsumerStatefulWidget {
  final dynamic label;
  final dynamic value;
  final ValueSetter<dynamic> onTap;

  const SymbolsKeyboardKey({
    super.key,
    @required this.label,
    required this.onTap,
    @required this.value,
  })  : assert(label != null),
        assert(value != null);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SymbolsKeyboardKeyState();
}

class _SymbolsKeyboardKeyState extends ConsumerState<SymbolsKeyboardKey> {
  bool isInTextStore = false;

  // renderLabel() {
  //   if (widget.label is String) {
  //     return Center(
  //       child: Text(
  //         widget.label,
  //         style: TextStyle(
  //           fontSize: 14.0,
  //           color: isInTextStore
  //               ? Colors.red
  //               : Colors.white, // Change color conditionally
  //         ),
  //         textAlign: TextAlign.center,
  //       ),
  //     );
  //   } else {
  //     return widget.label;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final symbols = ref.watch(symbolsNameProvider);

    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final padding = isMobile ? 1.8 : 3.6;
    final height = isMobile ? 40.0 : MediaQuery.of(context).size.height * 0.055;
    final width = isMobile ? 40.0 : screenWidth * 0.09;
    // final height = 40.0;
    // final width = 40.0;

    isInTextStore = symbols == widget.value;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 3,
            horizontal: padding,
          ),
          child: InkWell(
            splashColor: const Color.fromARGB(255, 120, 120, 120),
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            onTap: () {
              widget.onTap(widget.value);
              SystemSound.play(SystemSoundType.click);
            },
            // Color.fromARGB(255, 120, 120, 120),
            child: Ink(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: isInTextStore
                    ? const Color.fromARGB(255, 120, 120, 120)
                    : const Color(0xFF313131),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Center(
                child: Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight:
                        isInTextStore ? FontWeight.w800 : FontWeight.w600,
                    color: Colors.white, // Change color conditionally
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class EndKey extends ConsumerStatefulWidget {
  final dynamic label;
  final dynamic value;
  final ValueSetter<dynamic> onTap;

  const EndKey({
    super.key,
    @required this.label,
    required this.onTap,
    @required this.value,
  })  : assert(label != null),
        assert(value != null);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EndKeyState();
}

class _EndKeyState extends ConsumerState<EndKey> {
  renderLabel() {
    if (widget.label is String) {
      return Center(
        child: Text(
          widget.label,
          style: const TextStyle(fontSize: 14.0, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return widget.label;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final padding = isMobile ? 1.8 : 3.6;
    final height = isMobile ? 40.0 : MediaQuery.of(context).size.height * 0.055;
    final width = isMobile ? 36.0 : screenWidth * 0.09;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 3,
            horizontal:
                screenWidth > 600 ? screenWidth * 0.01 : screenWidth * 0.005,
            // Adjust the padding based on screen width
          ),
          child: InkWell(
            splashColor: const Color.fromARGB(255, 120, 120, 120),
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            onTap: () {
              widget.onTap(widget.value);
              SystemSound.play(SystemSoundType.click);
            },
            child: Ink(
              height: 40,
              width: width,
              decoration: BoxDecoration(
                color: const Color(0xFF313131),
                borderRadius: BorderRadius.circular(7),
              ),
              child: renderLabel(),
            ),
          ),
        ),
      ],
    );
  }
}

class Spacebar extends ConsumerStatefulWidget {
  final dynamic label;
  final dynamic value;
  final ValueSetter<dynamic> onTap;

  const Spacebar({
    super.key,
    @required this.label,
    required this.onTap,
    @required this.value,
  })  : assert(label != null),
        assert(value != null);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SpacebarState();
}

class _SpacebarState extends ConsumerState<Spacebar> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final height = isMobile ? 40.0 : screenHeight * 0.11;
    final width = isMobile ? screenWidth * 0.304 : screenWidth * 0.305;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      child: Column(
        children: [
          InkWell(
            splashColor: const Color.fromARGB(255, 120, 120, 120),
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            onTap: () {
              widget.onTap(widget.value);
              SystemSound.play(SystemSoundType.click);
            },
            child: Ink(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: const Color(0xFF313131),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Center(
                child: Text(
                  widget.label,
                  style: const TextStyle(fontSize: 14.0, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
