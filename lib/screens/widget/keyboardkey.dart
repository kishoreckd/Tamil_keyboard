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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
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
              width: 40,
              decoration: BoxDecoration(
                  color: const Color(0xFF313131),
                  borderRadius: BorderRadius.circular(7)),
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
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
              width: 100,
              decoration: BoxDecoration(
                  color: const Color(0xFF313131),
                  borderRadius: BorderRadius.circular(7)),
              child: renderLabel(),
            ),
          ),
        ),
      ],
    );
  }
}
