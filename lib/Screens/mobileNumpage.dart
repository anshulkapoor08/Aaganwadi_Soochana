import 'package:aaganwadi_soochna/Screens/homepage.dart';
import 'package:aaganwadi_soochna/Widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NamePage extends StatefulWidget {
  const NamePage({super.key});

  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  final _formKey = GlobalKey<FormState>();
  final numController = TextEditingController();

   @override
  void initState() {
    super.initState();
    numController.text = '+91 '; // Prepopulate with +91
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
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: RoundButton(
                  title: 'Next',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyHomePage()),
                    );
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
