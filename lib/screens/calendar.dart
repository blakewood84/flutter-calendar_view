import 'package:calendar_view/provider/schedule.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final _controller = ScrollController();
  @override
  void initState() {
    super.initState();
    context.read<ScheduleProvider>().init();
  }

  final startTime = DateTime(2022, 1, 1, 6);
  final endTime = DateTime(2022, 1, 1, 19);

  static final timesFormatter = DateFormat('h a');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        centerTitle: true,
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
