import 'package:flutter/material.dart';
import 'package:survey_mandiri/screen/login_screen.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
