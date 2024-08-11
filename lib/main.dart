import 'package:aaganwadi_soochna/View/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

 final bool _requireConsent = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
    OneSignal.initialize("87f41fe5-b08d-45b4-83e7-dbfb320a787f");
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.Debug.setAlertLevel(OSLogLevel.none);
    OneSignal.Notifications.clearAll();
     
    
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jan Suvidha',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
