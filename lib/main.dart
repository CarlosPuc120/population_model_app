import 'package:flutter/material.dart';
import 'package:population_model_app/screens/home_screen/home_screen.dart';


void main() {
  runApp(PopulationModelApp());
}

class PopulationModelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Modelo de Población',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}
