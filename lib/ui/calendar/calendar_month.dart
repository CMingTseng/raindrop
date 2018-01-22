import 'package:flutter/material.dart';
import 'package:raindrop/ui/calendar/calendar_day.dart';

class CalendarDayProperties {
  int day;
  CalendarDayType type;
  bool isBordered;

  CalendarDayProperties({this.day, this.type, this.isBordered});

  setType(CalendarDayType type) => this.type = type;
}

class CalendarMonth extends StatefulWidget {
  CalendarMonth(this.year, this.month);

  @override
  _CalendarMonthState createState() => new _CalendarMonthState();

  final int year;
  final int month;
}

class _CalendarMonthState extends State<CalendarMonth> {
  static const daysPerRow = 7;
  // TODO: Fix case where there are only 28 days where 1st is a Monday
  static const rowsPerMonth = 5;

  int _selectedDay;
  int _startOfMonthOffset = 0;
  List<CalendarDayProperties> _calendarDayProperties;

  void _handleDaySelected(int day) {
    setState(() {
      // Update the view for the previously selected day
      if (_selectedDay != null && _selectedDay != day) {
        _calendarDayProperties[_startOfMonthOffset + _selectedDay - 1]
            .setType(CalendarDayType.unselected);
      }

      // Update the view for the now-selected day
      _calendarDayProperties[_startOfMonthOffset + day - 1]
          .setType(CalendarDayType.selected);

      _selectedDay = day;
    });
  }

  List<Widget> _buildWidgetList() {
    List<List<Widget>> rowDays = new List();
    for (int i = 0; i < rowsPerMonth; i++) {
      rowDays.add([]);
    }

    for (int i = 0; i < _calendarDayProperties.length; i++) {
      rowDays[i ~/ daysPerRow].add(new CalendarDay(
        _calendarDayProperties[i].day,
        type: _calendarDayProperties[i].type,
        isBordered: _calendarDayProperties[1].isBordered,
        onChanged: _handleDaySelected,
      ));
    }

    List rows = new List();
    for (var rowDay in rowDays) {
      rows.add(new Row(
        children: rowDay,
      ));
    }

    return rows;
  }

  @override
  void initState() {
    super.initState();

    // Initialize empty variables
    _calendarDayProperties = new List();

    // Calculate start of month offset
    DateTime dateTime = new DateTime(widget.year, widget.month, 1);
    _startOfMonthOffset = dateTime.weekday - 1;

    // Append the disabled days of the previous month to _calendarDayProperties
    DateTime dayOnFirstMonday =
        dateTime.subtract(new Duration(days: _startOfMonthOffset));
    DateTime currentDay = dayOnFirstMonday;

    for (int i = 0; i < _startOfMonthOffset; i++) {
      _calendarDayProperties.add(new CalendarDayProperties(
        day: currentDay.day,
        type: CalendarDayType.disabled,
        isBordered: false,
      ));

      currentDay = currentDay.add(const Duration(days: 1));
    }

    // Fill in all the days of the month
    // Days after the current day are disabled
    int lastDayOfMonth = new DateTime(widget.year, widget.month + 1, 0).day;
    DateTime now = new DateTime.now();
    for (int i = 0; i < lastDayOfMonth; i++) {
      _calendarDayProperties.add(new CalendarDayProperties(
        day: currentDay.day,
        type: now.isAfter(dateTime)
            ? CalendarDayType.unselected
            : CalendarDayType.disabled,
        isBordered: false,
      ));

      currentDay = currentDay.add(const Duration(days: 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: const EdgeInsets.all(10.0),
        child: new Column(
          children: _buildWidgetList(),
        ));
  }
}
