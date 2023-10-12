import 'package:flutter/material.dart';

class NavigationItem {
  NavigationItem({
    required this.icon,
    this.label,
    Widget? activeIcon,
  }) : activeIcon = activeIcon ?? icon;

  final Widget icon;

  final Widget activeIcon;

  final String? label;
}
