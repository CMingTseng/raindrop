import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

enum CalendarDayType { disabled, unselected, selected }

class CalendarDay extends StatelessWidget {
  CalendarDay(
    this.day, {
    this.type = CalendarDayType.unselected,
    this.isBordered = false,
    @required this.onChanged,
  });

  final int day;

  final CalendarDayType type;
  final bool isBordered;

  final ValueChanged<int> onChanged;

  void _handleTap() {
    if (type == CalendarDayType.unselected) {
      onChanged(day);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double _diameter = MediaQuery.of(context).size.width / 10;
    final double _fontSize = MediaQuery.of(context).size.width / 25;

    return new GestureDetector(
      onTap: _handleTap,
      child: new AnimatedContainer(
        width: _diameter,
        height: _diameter,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          color: type == CalendarDayType.selected
              ? Theme.of(context).primaryColor
              : null,
          border: isBordered
              ? new Border.all(
            color: Theme.of(context).primaryColor,
            width: 2.0,
          )
              : null,
        ),
        child: new Center(
          child: new Text(
            day.toString(),
            style: new TextStyle(
              color: type == CalendarDayType.selected
                  ? Colors.white
                  : type == CalendarDayType.disabled
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
