import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/core/widgets/custom_elevated_button.dart';

class SocialSignInButton extends CustomElevatedButton {
  SocialSignInButton({
    required String label,
    required String image,
    required Color color,
    required Color fontColor,
    required VoidCallback? onPressed,
  }) : super(
          color: color,
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(image),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: fontColor,
                  fontSize: 18,
                ),
              ),
              Opacity(
                opacity: 0,
                child: Image.asset(image),
              ),
            ],
          ),
        );
}
