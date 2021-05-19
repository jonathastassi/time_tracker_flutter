import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/services/auth.dart';

class HomePage extends StatelessWidget {
  void _signOut(BuildContext context) async {
    final _auth = Provider.of<Auth>(context, listen: false);
    await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          TextButton(
            onPressed: () => _signOut(context),
            child: Text(
              "Logout",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
