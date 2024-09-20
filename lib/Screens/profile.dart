import 'package:aaganwadi_soochna/View/authValidator.dart';
import 'package:aaganwadi_soochna/View/secureStorage.dart';
import 'package:aaganwadi_soochna/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:badges/badges.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userNameProfile = '';
  String userPhoneProfile = '';
  String deviceIdProfile = '';

  
  Future<void> fetchUserData() async {
    final url =
        'https://anganwaadi-service-api.vercel.app/api/v1/client/signup'; 

    try {
      // Make the GET request to fetch user data
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // If the request is successful, parse the JSON response
        final Map<String, dynamic> data = json.decode(response.body);

        // Set the data into state variables
        setState(() {
          userNameProfile = data['name'];
          userPhoneProfile = data['phone'];
          deviceIdProfile = data['device_id'];
        });
      } else {
        // If the response status code is not 200, throw an error
        throw Exception('Failed to load user data');
      }
    } catch (error) {
      print('Error fetching user data: $error');
      
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch user data as soon as the screen loads
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile',
            style: TextStyle(fontFamily: 'Gilroy', fontSize: 25)),
        centerTitle: true,
        elevation: 2,
        backgroundColor: AppColors.whiteColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              userNameProfile.isEmpty &&
                      userPhoneProfile.isEmpty &&
                      deviceIdProfile.isEmpty
                  ? const Center(
                      child:
                          CircularProgressIndicator()) 
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name: $userNameProfile',
                            style: TextStyle(fontSize: 20)),
                        SizedBox(height: 10),
                        Text('Phone: $userPhoneProfile',
                            style: TextStyle(fontSize: 20)),
                        SizedBox(height: 10),
                        Text('Device ID: $deviceIdProfile',
                            style: TextStyle(fontSize: 20)),
                        SizedBox(height: 30),
                        ElevatedButton(
                            onPressed: () {
                              SecureStorageService().deleteAll();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Validate()),
                              );
                            },
                            child: Text('logout'))
                      ],
                    ),
            ],
          )),
    );
  }
}
