import 'screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';


void main() async {
  runApp(
    MaterialApp(
      theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.amber,
            ),
          ),
          hintStyle: TextStyle(
            color: Colors.amber,
          ),
        ),
      ),
      home: Home(),
    ),
  );
}

