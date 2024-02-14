import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/screens/tabs_screen.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(200, 6, 122, 145),
  ),
);
void main() {
  runApp(
    const ProviderScope(child:MyApp())
  );
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: theme,
      home: const TabsScreen(),
    );
  }
}

