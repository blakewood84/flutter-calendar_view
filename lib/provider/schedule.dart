// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer' as devtools;
import 'dart:io';

import 'package:flutter/material.dart';

@immutable
class ScheduleItem {
  final DateTime startTime;
  final DateTime endTime;
  final String name;
  final String description;

  const ScheduleItem({
    required this.startTime,
    required this.endTime,
    required this.name,
    required this.description,
  });

  ScheduleItem.fromMap(Map<String, dynamic> map)
      : startTime = DateTime.fromMillisecondsSinceEpoch(map['start_time']),
        endTime = DateTime.fromMillisecondsSinceEpoch(map['end_time']),
        name = map['name'],
        description = map['description'];

  @override
  String toString() {
    return 'ScheduleItem(startTime: $startTime, endTime: $endTime, name: $name, description: $description)';
  }
}

class ScheduleProvider extends ChangeNotifier {
  final scheduleList = <ScheduleItem>[];

  void init() async {
    final response = await HttpClient()
        .get('localhost', 5500, '/json/schedule.json')
        .then((request) => request.close())
        .then((response) => response.transform(utf8.decoder).join())
        .then((string) => jsonDecode(string) as List<dynamic>)
        .then((list) => list.map((item) => item));

    for (final schedule in response) {
      final scheduleItem = ScheduleItem.fromMap(schedule);
      scheduleList.add(scheduleItem);
    }
    notifyListeners();
  }
}
