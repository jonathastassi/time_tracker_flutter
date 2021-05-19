import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          TextButton(onPressed: () {}, child: Text("Logout", style: TextStyle(color: Colors.white,),))
        ],
      ),
    );
  }
}
