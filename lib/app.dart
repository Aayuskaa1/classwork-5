import 'package:flutter/material.dart';
import 'screens/books_screen.dart';

class Classwork5App extends StatelessWidget {
  const Classwork5App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Classwork 5',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true, 
        colorSchemeSeed: Colors.deepPurple,
      ),
      home: const BookScreen(),
    );
  }
}