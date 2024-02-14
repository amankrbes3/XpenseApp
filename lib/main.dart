import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories_screen.dart';
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
      MaterialApp(
        theme: theme,
        home: const TabsScreen(),
    )
  );
}

