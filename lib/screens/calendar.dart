import 'package:calendar_view/provider/schedule.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
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
  late final ScrollController _scroll1;
  late final ScrollController _scroll2;

  @override
  void initState() {
    super.initState();
    _controllers = LinkedScrollControllerGroup();
    _scroll1 = _controllers.addAndGet();
    _scroll2 = _controllers.addAndGet();
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
      appBar: AppBar(
        title: const Text('Calendar'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scroll1,
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    final time = startTime.add(Duration(hours: index));
                    return Container(
                      height: 75,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.purple,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.red,
                              ),
                            ),
                            width: 75,
                            child: Text(
                              timesFormatter.format(time),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scroll2,
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

                    // If an item ends here, reduce by 15

                    return Row(
                      children: [
                        // Space for Time
                        const SizedBox(width: 75),

                        // Space for Schedule Item
                        Container(
                          height: scheduleItemHeight > 0 ? 75.0 * scheduleItemHeight : 75.0,
                          width: size.width * .6,
                          color: item != null ? Colors.orange : Colors.transparent,
                        )
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
