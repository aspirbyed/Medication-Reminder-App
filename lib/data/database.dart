import 'package:hive_flutter/hive_flutter.dart';

class MedsTileDataBase {
  List medsNameList = [];

  // reference the box
  final _myBox = Hive.box('mybox');

  // run this method when whem first time opening app
  void createInitialData() {
    medsNameList = [
      [
        'Hello welcome to meds app',
        '2024-12-14 16:15:00',
        false,
        true,
        true,
        true,
        'N.A.'
      ],
    ];
  }

  // load the data from database
  void loadData() {
    medsNameList = _myBox.get("REMINDERS");
  }

  // update the database
  void updateDataBase() {
    _myBox.put("REMINDERS", medsNameList);
  }
}
