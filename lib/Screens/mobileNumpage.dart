import 'dart:convert';
import 'dart:developer';

import 'package:aaganwadi_soochna/Screens/homepage.dart';
import 'package:aaganwadi_soochna/View/secureStorage.dart';
import 'package:aaganwadi_soochna/Widgets/button.dart';
import 'package:aaganwadi_soochna/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class NamePage extends StatefulWidget {
  final String name;
  const NamePage({required this.name});

  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  final _formKey = GlobalKey<FormState>();
  final numController = TextEditingController();
  var error = '';
  @override
  void initState() {
    super.initState(); // Prepopulate with +91
    print(widget.name);
  }

  @override
  void dispose() {
    numController.dispose();
    super.dispose();
  }

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
      backgroundColor: Colors.white,
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
                  "What's your number?",
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
                      keyboardType: TextInputType.phone,
                      controller: numController,
                      decoration: const InputDecoration(
                        prefixText: '+91 ',
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(error),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: RoundButton(
                  title: 'Next',
                  onTap: () async {
                    var payerid;

                    await SecureStorageService()
                        .readValue('playerId')
                        .then((value) {
                      log('Player ID received from storage: $value');
                      payerid = value;
                    });

                    var res = await sendPlayerIdToBackend(
                        payerid, widget.name, '+91' + numController.text);
                    res = jsonDecode(res);
                    if (res['status'] == 'success' && res['error'] == false) {
                      log('Player ID sent to backend');
                      var successwrite = await SecureStorageService()
                          .writeValue('authToken', res['data']['authToken']);
                      if (successwrite) {
                        showSnackBar(context, 'successful signup',function: (){},label: 'get');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyHomePage()),
                        );
                      }
                    } else {
                      error = res['message'];
                      setState(() {});
                      showSnackBar(context, 'signup failed');
                      log('Failed to send Player ID to backend');
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

dynamic sendPlayerIdToBackend(
    String playerId, String name, String number) async {
  log('Sending Player ID to backend');
  final response = await http.post(
    Uri.parse('https://anganwaadi-service-api.vercel.app/api/v1/client/signup'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'name': name,
      'phoneNumber': number,
      'deviceId': playerId,
    }),
  );

  log('Response status: ${response.statusCode}');
  log('message: ${response.body}');

  return response.body;
}
