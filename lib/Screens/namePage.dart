import 'package:aaganwadi_soochna/Screens/mobileNumpage.dart';
import 'package:aaganwadi_soochna/Widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';

class MyNamePage extends StatefulWidget {
  const MyNamePage({super.key});

  @override
  State<MyNamePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyNamePage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  

  // Future<void> namePush(){
  //   await OneSignal.shared.setAppId();
  // }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      //backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                child: Stack(children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: const Text(
                  "What's your name?",
                  style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w900,
                      fontSize: 50),
                  softWrap: true,
                ),
              ),
            ])),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(top: 15, left: 20, right: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field cannot be empty';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: RoundButton(
                  title: 'Next',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MyNumPage(userName: nameController.text),
                        ),
                      );
                    } else {
                      
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
