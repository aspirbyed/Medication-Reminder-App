// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import, must_be_immutable

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MedsTile extends StatelessWidget {
  final String medName;
  final bool taskCompleted;
  final String dateTime;
  // final DateTime time;
  final bool repeat;
  final bool remind;
  final bool afterFood;
  final String note;
  Function()? openAlertBox;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  MedsTile({
    super.key,
    required this.medName,
    required this.taskCompleted,
    required this.dateTime,
    // required this.time,
    required this.repeat,
    required this.remind,
    required this.afterFood,
    required this.note,
    required this.openAlertBox,
    required this.onChanged,
    required this.deleteFunction,
  });

  // Variables
  List<String> days = [
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun",
  ];
  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];
  DateTime today = DateTime.now();
  // ----------

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(
          height: 70,
          padding: const EdgeInsets.all(17.0),
          decoration: BoxDecoration(
            color:
                !taskCompleted ? Colors.lightBlue[100] : Colors.blueGrey[400],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Column 1
              Container(
                // width: 32,
                // checkbox
                child: Checkbox(
                  value: taskCompleted,
                  onChanged: onChanged,
                  activeColor: Colors.black,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              // Column 2
              Expanded(
                child: GestureDetector(
                  onTap: openAlertBox,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // <<< Row 1 >>>
                      Expanded(
                        child: Row(
                          children: [
                            // meds name
                            Text(
                              medName, //.substring(0, min(25,medName.length)),
                              style: TextStyle(
                                decoration: taskCompleted
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                color: !taskCompleted
                                    ? Colors.grey[700]
                                    : Colors.blueGrey[50],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // *** Row 2 ***
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  (today.year ==
                                              DateTime.parse(dateTime).year &&
                                          today.month ==
                                              DateTime.parse(dateTime).month &&
                                          today.day ==
                                              DateTime.parse(dateTime).day)
                                      ? '☆Today, ${DateTime.parse(dateTime).day} ${months[DateTime.parse(dateTime).month - 1]}'
                                      : '${days[DateTime.parse(dateTime).weekday - 1]}, ${DateTime.parse(dateTime).day} ${months[DateTime.parse(dateTime).month - 1]}', //.substring(0, min(25,medName.length)),
                                  style: TextStyle(
                                    decoration: taskCompleted
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                    color: !taskCompleted
                                        ? Colors.grey[700]
                                        : Colors.blueGrey[50],
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  '${DateTime.parse(dateTime).hour} : ${DateTime.parse(dateTime).minute}', //.substring(0, min(25,medName.length)),
                                  style: TextStyle(
                                    decoration: taskCompleted
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                    color: !taskCompleted
                                        ? Colors.grey[700]
                                        : Colors.blueGrey[50],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                remind
                                    ? Icon(
                                        Icons.alarm,
                                        color: Colors.black12,
                                      )
                                    : SizedBox.shrink(),
                                SizedBox(width: 2),
                                repeat
                                    ? Icon(
                                        Icons.autorenew,
                                        color: Colors.black12,
                                      )
                                    : SizedBox.shrink(),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // *** Row 3 ***
                      // Row(
                      //   children: [
                      //     SizedBox(
                      //       height: 100,
                      //       width: 100,
                      //     ),
                      //     SizedBox.expand(),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
