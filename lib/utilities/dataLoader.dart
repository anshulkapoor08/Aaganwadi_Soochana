import'package:flutter/material.dart';

class DataLoaderExample extends StatefulWidget {
  @override
  _DataLoaderExampleState createState() => _DataLoaderExampleState();
}

class _DataLoaderExampleState extends State<DataLoaderExample> {
  // Simulate a network call or data fetch
  Future<String> fetchData() async {
    await Future.delayed(Duration(seconds: 3)); // simulate delay
    return 'Data loaded successfully';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Data Loader Example')),
      body: Center(
        child: FutureBuilder<String>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show loading indicator while waiting for data
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // Show error message if there's an error
              return Text('Error: ${snapshot.error}');
            } else {
              // Show the data once it's loaded
              return Text(snapshot.data ?? 'No data');
            }
          },
        ),
      ),
    );
  }
}