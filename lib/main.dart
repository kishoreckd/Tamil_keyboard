import 'package:flutter/material.dart';
import 'package:keyboard_tamil/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:keyboard_tamil/screens/keyboard.dart';

// ignore_for_file: avoid_print

// void main() => runApp(const MaterialApp(home: TamilKeyboard()));

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: Keyboard()));
}

