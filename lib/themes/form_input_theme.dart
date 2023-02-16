import 'package:flutter/material.dart';

class FormInputTheme {
  TextStyle _buildTextStyle(Color color, {double size = 16.0}) {
    return TextStyle(
      color: color,
      fontSize: size,
    );
  }

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: color,
        width: 1.0,
      ),
    );
  }

  InputDecorationTheme theme() => InputDecorationTheme(
    contentPadding: const EdgeInsets.all(16),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    constraints: const BoxConstraints(maxWidth: 150),
    enabledBorder: _buildBorder(Colors.grey[600]!),
    errorBorder: _buildBorder(Colors.red),
    focusedErrorBorder: _buildBorder(Colors.green),
    focusedBorder: _buildBorder(Colors.blue),
    disabledBorder: _buildBorder(Colors.grey[400]!),
    suffixStyle: _buildTextStyle(Colors.white),
    counterStyle: _buildTextStyle(Colors.grey, size: 12.0),
    floatingLabelStyle: _buildTextStyle(Colors.white),
    errorStyle: _buildTextStyle(Colors.red, size: 12.0),
    helperStyle: _buildTextStyle(Colors.white, size: 12.0),
    hintStyle: _buildTextStyle(Colors.grey),
    labelStyle: _buildTextStyle(Colors.white),
    prefixStyle: _buildTextStyle(Colors.white),
  );
}
