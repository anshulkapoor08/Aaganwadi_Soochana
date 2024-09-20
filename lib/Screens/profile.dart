import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // To decode the JSON response

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userNameProfile = '';
  String userPhoneProfile = '';
  String deviceIdProfile = '';

  // Function to fetch data from the backend
  Future<void> fetchUserData() async {
    final url = 'https://anganwaadi-service-api.vercel.app/api/v1/client/signup'; // Replace with your backend URL

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
      // You can also show an error message to the user
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
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: userNameProfile.isEmpty && userPhoneProfile.isEmpty && deviceIdProfile.isEmpty
            ? Center(child: CircularProgressIndicator()) // Show a loading spinner while fetching
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: $userNameProfile', style: TextStyle(fontSize: 20)),
                  SizedBox(height: 10),
                  Text('Phone: $userPhoneProfile', style: TextStyle(fontSize: 20)),
                  SizedBox(height: 10),
                  Text('Device ID: $deviceIdProfile', style: TextStyle(fontSize: 20)),
                ],
              ),
      ),
    );
  }
}
