import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges; // Import the badges package

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Unread Messages Example'),
        ),
        body: Center(
          child: UnreadMessagesIcon(unreadCount: 5), // Example with 5 unread messages
        ),
      ),
    );
  }
}

class UnreadMessagesIcon extends StatelessWidget {
  final int unreadCount;

  UnreadMessagesIcon({required this.unreadCount});

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      badgeContent: Text(
        unreadCount.toString(), // Display the unread count
        style: TextStyle(color: Colors.white), // Badge text color
      ),
      badgeStyle: badges.BadgeStyle(
        badgeColor: Colors.blue, // Set the background color using badgeStyle
      ), // Badge background color
      position: badges.BadgePosition.topEnd(top: -10, end: -10), // Badge position relative to the icon
      child: Icon(
        Icons.message, // Your message icon
        size: 40,      // Icon size
      ),
    );
  }
}
