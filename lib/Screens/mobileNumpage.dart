import 'dart:convert';
import 'dart:developer';
import 'package:aaganwadi_soochna/Screens/homepage.dart';
import 'package:aaganwadi_soochna/View/secureStorage.dart';
import 'package:aaganwadi_soochna/Widgets/button.dart';
import 'package:aaganwadi_soochna/utilities/showSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class MyNumPage extends StatefulWidget {
  final String name;
  const MyNumPage({required this.name});

  @override
  State<MyNumPage> createState() => _NamePageState();
}

class _NamePageState extends State<MyNumPage> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final numController = TextEditingController();
  var error = '';

  @override
  void initState() {
    super.initState();
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: numController,
                      maxLength: 10,
                      decoration: const InputDecoration(
                        prefixText: '+91 ',
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        counterText: '',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        } else if (value.length != 10) {
                          return 'Phone number must be exactly 10 digits';
                        } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                          return 'Phone number must contain only digits';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(error),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: !_isLoading ? RoundButton(
                  title: 'Next',
                  onTap: () async {
                    // Validate the form
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isLoading = true; // Show loader
                      });

                      // If valid, proceed with the backend request
                      var payerid =
                          await SecureStorageService().readValue('playerId');
                      log('Player ID received from storage: $payerid');

                      if (payerid == null) {
                        setState(() {
                          _isLoading = false;
                        });
                        showSnackBar(
                            context, 'Player ID not found. Please try again.');
                        log('Player ID is null');
                        return; // Stop further execution if playerId is null
                      }
                      try {
                        var res = await sendPlayerIdToBackend(
                            payerid, widget.name, '+91' + numController.text);
                        res = jsonDecode(res);

                        if (res['status'] == 'success' &&
                            res['error'] == false) {
                          log('Player ID sent to backend');
                          var successwrite = await SecureStorageService()
                              .writeValue(
                                  'authToken', res['data']['authToken']);
                          if (successwrite) {
                            showSnackBar(context, 'Successful signup',
                                function: () {}, label: 'get');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyHomePage()),
                            );
                          }
                        } else {
                          error = res['message'];
                          setState(() {});
                          showSnackBar(context, 'Signup failed');
                          log('Failed to send Player ID to backend');
                        }
                      } catch (e) {
                        log('Error: $e');
                        showSnackBar(
                            context, 'An error occurred. Please try again.');
                      } finally {
                        setState(() {
                          _isLoading = false; // Hide loader
                        });
                      }
                    } else {
                      // If not valid, show a snackbar or an error message
                      showSnackBar(
                          context, 'Please enter a valid phone number');
                    }
                    
                  },
                ): CircularProgressIndicator(), 
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
