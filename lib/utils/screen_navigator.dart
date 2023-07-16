import 'package:flutter/material.dart';

void navigateScreen(BuildContext context, Widget content) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (ctx) => content,
    ),
  );
}
