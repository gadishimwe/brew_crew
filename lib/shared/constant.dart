import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
    color: Colors.white,
    width: 2,
  )),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
    color: Colors.brown,
    width: 2,
  )),
  errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
    color: Colors.red,
    width: 2,
  )),
  focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
    color: Colors.red,
    width: 2,
  )),
);
