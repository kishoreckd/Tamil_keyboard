import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_tamil/widgets/homepage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Keyboard extends ConsumerStatefulWidget {
  const Keyboard({super.key});

  @override
  ConsumerState<Keyboard> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<Keyboard> {
  bool isDeviceSupport = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'app',
      onGenerateTitle: (BuildContext context) => 'Tamil keyboard',
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        }),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      home: const MyHomePage(),
    );
  }
}
