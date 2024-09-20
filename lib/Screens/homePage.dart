import 'package:aaganwadi_soochna/Screens/profile.dart';
import 'package:aaganwadi_soochna/View/authValidator.dart';
import 'package:aaganwadi_soochna/View/secureStorage.dart';
import 'package:flutter/material.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Notifications', style: TextStyle(
                      fontFamily: 'Gilroy',
                      // fontWeight: FontWeight.w900,
                      fontSize: 30),),
        centerTitle: true,
         actions: [
          Padding(
          padding:const EdgeInsets.symmetric(horizontal: 8.0),
           child: IconButton(
            icon: Icon(Icons.account_circle, size: 35,), 
            onPressed: () {
              
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
              
            },
            ),
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Text(
      //         'Welcome to Jan Suvidha',
      //         style: TextStyle(fontSize: 20),
      //       ),
      //       ElevatedButton(onPressed: (){
      //         SecureStorageService().deleteAll();
      //           Navigator.pushReplacement(
      //             context,
      //             MaterialPageRoute(builder: (context) => Validate()),
      //           );
      //       }, child: Text('Logout'))
      //     ],
      //   ),
      // ),
      
    );
  }
}