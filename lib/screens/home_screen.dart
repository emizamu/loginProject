import 'package:flutter/material.dart';

// Solamente simulamos un HomeScreen para el boton de Inicio

class HomeScreen extends StatelessWidget { 
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
         child: Text('HomeScreen'),
      ),
    );
  }
}