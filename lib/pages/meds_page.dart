// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unused_import

import 'package:flutter/material.dart';
import 'package:med_app/Services/notifi_service.dart';
import 'package:med_app/data/database.dart';
import 'package:med_app/util/dialog_page_2.dart';
import 'package:med_app/util/dialog_page_1.dart';
import 'package:med_app/util/meds_tile.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MedsPage extends StatefulWidget {
  const MedsPage({super.key});

  @override
  State<MedsPage> createState() => _MedsPageState();
}

class _MedsPageState extends State<MedsPage> {
  final _myBox = Hive.box('mybox');
  MedsTileDataBase db = MedsTileDataBase();

  @override
  void initState() {
    // if this is the first time opening the app
    if (_myBox.get("REMINDERS") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  // List format:
  // ┌───────────────┬────────────┬───────────────┬─────────┬─────────┬───────────┬───────┐
  // │ medName       │ dateTime   │ taskCompleted │ repeat  │ remind  │ afterFood │ note  │
  // └───────────────┴────────────┴───────────────┴─────────┴─────────┴───────────┴───────┘

  // List medsNameList = [
  //   ['Aspirin', '2024-12-13 12:30:00', false, false, true, true, 'N.A.'],
  //   ['Paracetamol', '2024-12-12 13:30:00', false, true, false, true, 'N.A.'],
  //   ['Glucose', '2024-12-12 14:30:00', true, true, true, true, 'N.A.'],
  //   ['Vicks', '2024-12-12 15:30:00', false, true, true, true, 'N.A.'],
  // ];

  // Controller:
  final dynamic _controller = TextEditingController();
  final dynamic _textControllerName = TextEditingController();
  final dynamic _textControllerNote = TextEditingController();
  final dynamic _dateTimeController = TextEditingController();
  final dynamic _afterFoodController = TextEditingController();
  final dynamic _repeatController = TextEditingController();

  // function for handling different tasks:
  // save state
  void saveNewTask() async {
    // NotificationService().showNotification(title: 'Remainder', body: _textControllerName.text);
    if (DateTime.parse(_dateTimeController.text).isAfter(DateTime.now())) {
      LocalNotifications.showScheduleNotification(
        id: db.medsNameList.length,
        title: 'Reminder',
        body: _textControllerName.text,
        notificationTime: DateTime.parse(_dateTimeController.text),
      );
    }
    setState(() {
      db.medsNameList.add([
        _textControllerName.text,
        _dateTimeController.text,
        false,
        (_repeatController.text.toString().toLowerCase() == 'true'),
        (_dateTimeController != null),
        (_afterFoodController.text.toString().toLowerCase() == 'true'),
        _textControllerNote.text
      ]);
      _textControllerName.clear();
      _textControllerNote.clear();
      _dateTimeController.clear();
      _afterFoodController.clear();
      _repeatController.clear();
    });
    Navigator.pop(context);
    db.updateDataBase();
  }

  // add dialog box FOR NEW MEDS
  void addDialogBox() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox1(
          textControllerName: _textControllerName,
          dateTimeController: _dateTimeController,
          repeatController: _repeatController,
          afterFoodController: _afterFoodController,
          textControllerNote: _textControllerNote,
          onAdd: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // open alert box on clicking the tasks
  void openAlertBox() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox2(
          controller: _controller,
          onSave: () {},
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // updating checkbox function:
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.medsNameList[index][2] = !db.medsNameList[index][2];
      // if (db.medsNameList[index][3] && db.medsNameList[index][2] == true) {
      //   _textControllerName.text = db.medsNameList[index][0];
      //   _dateTimeController.text = db.medsNameList[index][1];
      //   _repeatController.text = db.medsNameList[index][3];
      //   // remind controller...
      //   _afterFoodController.text = db.medsNameList[index][5];
      //   _textControllerNote.text = db.medsNameList[index][6];
      //   saveNewTask();
      // }
    });
    db.updateDataBase();
  }

  // deleting a task
  void deleteTask(int index) {
    setState(() {
      db.medsNameList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: addDialogBox,
        backgroundColor: Colors.blueGrey[50],
        child: Icon(
          Icons.add,
          color: Colors.blue,
        ),
        shape: CircleBorder(),
      ),
      body: ListView.builder(
          itemCount: db.medsNameList.length,
          itemBuilder: (context, index) {
            return MedsTile(
              medName: db.medsNameList[index][0],
              taskCompleted: db.medsNameList[index][2],
              dateTime: db.medsNameList[index][1],
              repeat: db.medsNameList[index][3],
              remind: db.medsNameList[index][4],
              afterFood: db.medsNameList[index][5],
              note: db.medsNameList[index][6],
              openAlertBox: openAlertBox,
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
            );
          }),
    );
  }
}
