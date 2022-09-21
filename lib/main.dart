import 'package:calendar_view/provider/schedule.dart';
import 'package:flutter/material.dart';

import 'package:calendar_view/screens/calendar.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
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

class NewCalendarScreen extends StatefulWidget {
  const NewCalendarScreen({Key? key}) : super(key: key);

  @override
  State<NewCalendarScreen> createState() => _NewCalendarScreenState();
}

class _NewCalendarScreenState extends State<NewCalendarScreen> {
  late LinkedScrollControllerGroup _controllers;
  late final ScrollController _scroll1; // Y
  late final ScrollController _scroll2; // Y

  @override
  void initState() {
    super.initState();
    _controllers = LinkedScrollControllerGroup();
    _scroll1 = _controllers.addAndGet();
    _scroll2 = _controllers.addAndGet();
    context.read<ScheduleProvider>().init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: 550, // If I give a set width here it will still scroll horizontally and vertically
                    height: constraints.maxHeight,
                    child: ListView(
                      children: [
                        Container(
                          height: 100,
                          width: 30,
                          color: Colors.blue,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 100,
                          width: 30,
                          color: Colors.blue,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 100,
                          width: 30,
                          color: Colors.blue,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 100,
                          width: 30,
                          color: Colors.blue,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 100,
                          width: 30,
                          color: Colors.blue,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 100,
                          width: 30,
                          color: Colors.blue,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 100,
                          width: 30,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
