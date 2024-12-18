// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DialogBox1 extends StatefulWidget {
  final textControllerName;
  final textControllerNote;
  final dateTimeController;
  final repeatController;
  final afterFoodController;
  VoidCallback onAdd;
  VoidCallback onCancel;

  DialogBox1({
    super.key,
    // required BuildContext context,
    required this.textControllerName,
    required this.dateTimeController,
    required this.repeatController,
    required this.afterFoodController,
    required this.textControllerNote,
    required this.onAdd,
    required this.onCancel,
  });

  @override
  State<DialogBox1> createState() => _DialogBox1State();
}

class _DialogBox1State extends State<DialogBox1> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.topCenter,
      backgroundColor: Colors.white,
      content: Container(
        alignment: Alignment.center,
        width: 400,
        height: 500,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text('Hello...'),
              Text('New Task'),
              TextField(
                controller: widget.textControllerName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  fillColor: Colors.white,
                  hintText: 'Add med name',
                ),
              ),
              TextField(
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(3000),
                  ).then((value) {
                    if (value != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(value);
                      showTimePicker(
                              context: context, initialTime: TimeOfDay.now())
                          .then((value) {
                        if (value != null) {
                          String formattedTime =
                              '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}:00';
                          widget.dateTimeController.text =
                              '$formattedDate $formattedTime';
                        }
                      });
                    }
                  });
                },
                controller: widget.dateTimeController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Add date & time',
                ),
              ),
              TextField(
                controller: widget.repeatController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Repeat? true or false',
                ),
              ),
              TextField(
                controller: widget.afterFoodController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'After food? true or false',
                ),
              ),
              TextField(
                controller: widget.textControllerNote,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Notes...',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    onPressed: widget.onAdd,
                    color: Colors.white,
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  MaterialButton(
                    onPressed: widget.onCancel,
                    color: Colors.white,
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
