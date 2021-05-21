import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<bool?> showAlertDialog(
  BuildContext context, {
  required String title,
  required String content,
  String okLabelButton = "OK",
  String? cancelLabelButton,
}) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      if (Platform.isIOS) {
        return CupertinoAlertDialog(
          title: Text(
            title,
          ),
          content: Text(content),
          actions: <Widget>[
            if (cancelLabelButton != null)
              TextButton(
                child: Text(cancelLabelButton),
                onPressed: () {
                  Navigator.of(context).pop<bool>(false);
                },
              ),
            TextButton(
              child: Text(okLabelButton),
              onPressed: () {
                Navigator.of(context).pop<bool>(true);
              },
            ),
          ],
        );
      }
      return AlertDialog(
        title: Text(
          title,
        ),
        content: Text(content),
        actions: <Widget>[
          if (cancelLabelButton != null)
            TextButton(
              child: Text(cancelLabelButton),
              onPressed: () {
                Navigator.of(context).pop<bool>(false);
              },
            ),
          TextButton(
            child: Text(okLabelButton),
            onPressed: () {
              Navigator.of(context).pop<bool>(true);
            },
          ),
        ],
      );
    },
  );
}
