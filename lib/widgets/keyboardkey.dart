import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KeyboardKey extends StatefulWidget {
  final dynamic label;
  final dynamic value;
  final ValueSetter<dynamic> onTap;

  const KeyboardKey({
    super.key,
    @required this.label,
    required this.onTap,
    @required this.value,
  })  : assert(label != null),
        assert(value != null);

  @override
  State<KeyboardKey> createState() => _KeyboardKeyState();
}

class _KeyboardKeyState extends State<KeyboardKey> {
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
    final width = isMobile ? 40.0 : screenWidth * 0.09;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 3,
            horizontal: padding,
          ),
          child: InkWell(
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

class EndKey extends StatefulWidget {
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
  State<EndKey> createState() => _EndKeyState();
}

class _EndKeyState extends State<EndKey> {
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

class Spacebar extends StatefulWidget {
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
  State<Spacebar> createState() => _SpacebarState();
}

class _SpacebarState extends State<Spacebar> {
  renderLabel() {
    return Center(
      child: Text(
        widget.label,
        style: const TextStyle(fontSize: 14.0, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }

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
        ],
      ),
    );
  }
}
