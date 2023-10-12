import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({super.key, required this.icon, this.label, this.onTap});

  final Widget icon;
  final String? label;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [icon, Text(label ?? '')],
        ),
      ),
    );
  }
}
