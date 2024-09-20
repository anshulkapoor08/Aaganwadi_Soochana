import 'package:aaganwadi_soochna/Screens/profile.dart';
import 'package:aaganwadi_soochna/utilities/colors.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(fontFamily: 'Gilroy', fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: AppColors.whiteColor,
        elevation: 2,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            
            child: IconButton(
          icon: Icon(Icons.message, size: 30,color: AppColors.blackColor,),
          onPressed: () {
            
          },
        ),
          ),
        ],
        leading: IconButton(
              icon: Icon(
                Icons.account_circle,
                size: 30,color: AppColors.blackColor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
      ),
      
    );
  }
}
