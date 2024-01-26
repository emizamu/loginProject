import 'package:flutter/material.dart';

class InputDecorations {

  static InputDecoration authInputDecoration({ // Maneja el diseño de los inputs de contraseña e emial.
    required String hintText,
    required String labelText,
    IconData? prefixIcon}) {
  

    return InputDecoration(
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.deepPurple)),
        focusedErrorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.deepPurple, 
              width: 2)),
        hintText: hintText,
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.grey),
        prefixIcon: prefixIcon != null ? Icon(
          prefixIcon, color: Colors.deepPurple) :null
        );
  }
}
