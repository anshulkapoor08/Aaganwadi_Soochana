import 'package:flutter/material.dart';
void showSnackBar(BuildContext context, String message,
    {Function()? function, String? label}) {
  final snackBar = SnackBar(
    content: Text(message),
    duration:
        const Duration(seconds: 2), // Duration the SnackBar will be visible
    backgroundColor: Colors.black, // Background color of the SnackBar
    action: label != null
        ? SnackBarAction(
            label: label, // Action label
            onPressed: function ?? () {}, // Action function or a no-op function
          )
        : null, // No action if label is null
  );
}
