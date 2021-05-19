import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/ui/home/home_page.dart';
import 'package:time_tracker_flutter_course/app/ui/sign_in/sign_in_page.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SignInPage();
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
