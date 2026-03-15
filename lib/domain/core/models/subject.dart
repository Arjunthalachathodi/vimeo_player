import 'package:flutter/material.dart';

class Subject {
  final String name;
  final int widgets;
  final int items;
  final IconData icon;
  final Color color;
  final Color bgColor;

  const Subject({
    required this.name,
    required this.widgets,
    required this.items,
    required this.icon,
    required this.color,
    required this.bgColor,
  });
}
