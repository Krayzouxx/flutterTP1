import 'package:flutter/material.dart';
import 'conversion_screen.dart';

void main() {
  runApp(ConvertisseurApp());
}

class ConvertisseurApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Convertisseur de Mesures',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ConversionScreen(),
    );
  }
}
