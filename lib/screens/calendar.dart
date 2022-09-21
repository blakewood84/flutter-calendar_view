import 'package:calendar_view/provider/schedule.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as devtools;

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late LinkedScrollControllerGroup _controllers;
  late LinkedScrollControllerGroup _controllers2;
  late final ScrollController _scroll1; // Y
  late final ScrollController _scroll2; // Y
  late final ScrollController _scroll3; // X
  late final ScrollController _scroll4; // X ->

  @override
  void initState() {
    super.initState();
    _controllers = LinkedScrollControllerGroup();
    _controllers2 = LinkedScrollControllerGroup();
    _scroll1 = _controllers.addAndGet();
    _scroll2 = _controllers.addAndGet();
    _scroll3 = _controllers2.addAndGet();
    _scroll4 = _controllers2.addAndGet();
    context.read<ScheduleProvider>().init();
  }

  final startTime = DateTime(2022, 1, 1, 6);
  final endTime = DateTime(2022, 1, 1, 19);

  static final timesFormatter = DateFormat('h a');

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final scheduleList = context.watch<ScheduleProvider>().scheduleList;

    if (scheduleList.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              controller: _scroll3,
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 800, // If I give a set width here it will still scroll horizontally and vertically
                height: size.height,
                child: ListView.builder(
                  controller: _scroll1,
                  scrollDirection: Axis.vertical,
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    final time = startTime.add(Duration(hours: index));
                    return Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 1,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          // Space for Time
                          SizedBox(
                            width: 75,
                            height: 75,
                            child: Text(timesFormatter.format(time)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _scroll4,
              child: SizedBox(
                width: 800, // If I give a set width here it will still scroll horizontally and vertically
                height: size.height,
                child: ListView.builder(
                  controller: _scroll2,
                  scrollDirection: Axis.vertical,
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    final time = startTime.add(Duration(hours: index));
                    devtools.log('----------------------------');
                    devtools.log('\nRow Start Time: ${time.hour}');
                    // Expand the schedule item to the end time

                    // Find a schedule Item that starts at this time
                    final item = context
                        .read<ScheduleProvider>()
                        .scheduleList
                        .singleWhereOrNull((schedule) => schedule.startTime.hour == time.hour);

                    if (item != null) {
                      devtools.log('Schedule Item Start Time: ${item.startTime.toIso8601String()}');
                      devtools.log('Schedule Item End Time: ${item.endTime.toIso8601String()}');
                      devtools.log('\n----------------------------');
                    }

                    // Expand to it's end time. Check to see if it expands past it's end time
                    final scheduleItemHeight = item == null ? 0 : item.endTime.hour - item.startTime.hour;

                    return Row(
                      children: [
                        // Space for Time
                        SizedBox(
                          width: 75,
                          height: 76,
                          child: Text(
                            timesFormatter.format(time),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
