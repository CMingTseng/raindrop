import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum CalendarDayType { disabled, unselected, selected }

class CalendarDay extends StatefulWidget {
  CalendarDay(this.day,
      {this.type = CalendarDayType.unselected, this.isBordered = false});

  final int day;
  final CalendarDayType type;
  final bool isBordered;

  @override
  _CalendarDayState createState() => new _CalendarDayState();
}

class _CalendarDayState extends State<CalendarDay> {
  CalendarDayType _type;
  bool _isBordered;

  double _diameter;
  double _fontSize;

  void _handleTap() {
    setState(() {
      switch (_type) {
        case CalendarDayType.disabled:
          _type = CalendarDayType.selected;
          break;
        case CalendarDayType.selected:
          _type = CalendarDayType.unselected;
          break;
        case CalendarDayType.unselected:
          _type = CalendarDayType.disabled;
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _type = widget.type;
    _isBordered = widget.isBordered;
  }

  @override
  Widget build(BuildContext context) {
    _diameter = MediaQuery.of(context).size.width / 11;
    _fontSize = MediaQuery.of(context).size.width / 26;

    return new GestureDetector(
      onTap: _handleTap,
      child: new AnimatedContainer(
        width: _diameter,
        height: _diameter,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          color: _type == CalendarDayType.selected
              ? Theme.of(context).primaryColor
              : null,
          border: _isBordered
              ? new Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 2.0,
                )
              : null,
        ),
        child: new Center(
          child: new Text(
            widget.day.toString(),
            style: new TextStyle(
              color: _type == CalendarDayType.selected
                  ? Colors.white
                  : _type == CalendarDayType.disabled
                      ? Colors.grey
                      : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: _fontSize,
            ),
          ),
        ),
        duration: const Duration(milliseconds: 40),
      ),
    );
  }
}
