import 'package:flutter/material.dart';

class FilterTag {
  final String name;
  bool isSelected;
  final IconData icon;
  final Widget menu;

  FilterTag({
    required this.name,
    required this.isSelected,
    required this.icon,
    required this.menu,
  });
}
