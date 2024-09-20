import 'package:aaganwadi_soochna/View/secureStorage.dart';
import 'package:aaganwadi_soochna/View/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'dart:developer';

var player;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  log('ebnabled');
  OneSignal.shared.setAppId('87f41fe5-b08d-45b4-83e7-dbfb320a787f');
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    log('Notification permission: ${accepted ? 'granted' : 'denied'}');
  });
  try {
    OneSignal.shared.getDeviceState().then((deviceState) async {
      if (deviceState != null) {
        String playerId = deviceState.userId!;
        player = playerId;
        if (await SecureStorageService().writeValue('playerId', playerId)) {
          log('Player ID: $playerId');
        } else {
          log('Failed to write Player ID to storage');
        }
      }
    });
  } catch (er) {
    log(er.toString());
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jan Suvidha',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      home: const SplashScreen(),
    );
  }
}
