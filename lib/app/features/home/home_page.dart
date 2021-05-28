import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/core/widgets/show_alert_dialog.dart';
import 'package:time_tracker_flutter_course/app/services/auth.dart';

class HomePage extends StatelessWidget {
  void _signOut(BuildContext context) async {
    final _auth = Provider.of<Auth>(context, listen: false);
    await _auth.signOut();
  }

  void _confirmSignOut(BuildContext context) async {
    final response = await showAlertDialog(
      context,
      title: "Confirm sign",
      content: "Are you really want do get out?",
      okLabelButton: "YES",
      cancelLabelButton: "NO",
    );

    if (response == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          TextButton(
            onPressed: () => _confirmSignOut(context),
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
