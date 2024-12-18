// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class DialogBox2 extends StatefulWidget {
  final dynamic controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox2({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<DialogBox2> createState() => _DialogBox2State();
}

class _DialogBox2State extends State<DialogBox2> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        alignment: Alignment.bottomCenter,
        height: 200,
        width: 300,
        child: const Text('Editing Dialog Box::: UNDER CONSTRUCTION'),
      ),
    );
  }
}
