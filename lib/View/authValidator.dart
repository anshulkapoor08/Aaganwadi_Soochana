import 'package:aaganwadi_soochna/Screens/homePage.dart';
import 'package:aaganwadi_soochna/Screens/onboardingPage.dart';
import 'package:aaganwadi_soochna/View/secureStorage.dart';
import 'package:flutter/material.dart';

class Validate extends StatefulWidget {
  const Validate({super.key});

  @override
  State<Validate> createState() => _ValidateState();
}

class _ValidateState extends State<Validate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: SecureStorageService().containsKey('authToken'),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show loading indicator while the future is being resolved
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Handle error state
            return Center(child: Text('Error occurred: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            // If authToken exists, navigate to HomePage, otherwise go to LoginPage
            if (snapshot.data == true) {
              return MyHomePage(); // Make sure you have imported MyHomePage
            } else {
              return GetStarted(); // Make sure you have imported MyLoginPage
            }
          } else {
            // Handle unexpected state (if any)
            return Center(child: Text('Unexpected state'));
          }
        },
      ),
    );
  }
}
