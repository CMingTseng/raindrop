import 'package:flutter/material.dart';
import 'package:raindrop/ui/calendar/calendar_month.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => new _CalendarState();
}

class _CalendarState extends State<Calendar> {
  int _year;
  int _month;

  @override
  void initState() {
    super.initState();

    DateTime now = new DateTime.now();
    _year = now.year;
    _month = now.month;
  }

  @override
  Widget build(BuildContext context) {
    return new CalendarMonth(_year, _month);
  }
}
