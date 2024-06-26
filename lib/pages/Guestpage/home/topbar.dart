import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
    required this.margin,
    required this.leftIcon,
    required this.rightIcon,
    required this.title,
    required this.titleColor,
  });

  final EdgeInsets margin;
  final Widget leftIcon;
  final Widget rightIcon;
  final String title;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Row(
        children: [
          leftIcon,
          Expanded(
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: titleColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          rightIcon,
        ],
      ),
    );
  }
}
