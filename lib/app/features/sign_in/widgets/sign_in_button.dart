import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/core/widgets/custom_elevated_button.dart';

class SignInButton extends CustomElevatedButton {
  SignInButton({
    required String label,
    required Color color,
    required Color fontColor,
    required VoidCallback? onPressed,
  }) : super(
          color: color,
          onPressed: onPressed,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: fontColor,
              fontSize: 18,
            ),
          ),
        );
}
