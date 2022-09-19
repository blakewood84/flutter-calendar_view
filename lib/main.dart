import 'package:calendar_view/provider/schedule.dart';
import 'package:flutter/material.dart';

import 'package:calendar_view/screens/calendar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ScheduleProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Calendar Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const CalendarScreen(),
      ),
    );
  }
}
