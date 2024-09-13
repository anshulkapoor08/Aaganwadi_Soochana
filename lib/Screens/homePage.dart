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
        title: Text('Jan Suvidha'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to Jan Suvidha',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(onPressed: (){
              SecureStorageService().deleteAll();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Validate()),
                );
            }, child: Text('Logout'))
          ],
        ),
      ),
      
    );
  }
}