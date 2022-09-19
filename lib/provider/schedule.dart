import 'dart:io';
import 'dart:convert';
import 'dart:developer' as devtools;

import 'package:flutter/material.dart';

class ScheduleProvider extends ChangeNotifier {
  void init() async {
    final response = await HttpClient()
        .get('localhost', 5500, '/json/schedule.json')
        .then((request) => request.close())
        .then((response) => response.transform(utf8.decoder).join());

    devtools.log(response.toString());
  }
}
