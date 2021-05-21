import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color color;
  final double height;
  final Widget child;
  final bool enabled;

  CustomElevatedButton({
    required this.onPressed,
    required this.color,
    required this.child,
    this.height = 60,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        primary: color,
        minimumSize: Size.fromHeight(height),
      ),
      child: child,
    );
  }
}
