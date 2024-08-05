import 'dart:math';

import 'package:aaganwadi_soochna/View/homepage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  final List<String> onboarding = [];

  Color whitecolor = Colors.white;
  Color mainColor = const Color(0xFF333333);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: whitecolor,
      body: ImageCarouselSlider(),
    );
  }
}

@override
class ImageCarouselSlider extends StatefulWidget {
  @override
  _ImageCarouselSliderState createState() => _ImageCarouselSliderState();
}

class _ImageCarouselSliderState extends State<ImageCarouselSlider> {
  final List<String> imgList = [
    'images/Medicines.png',
    'images/NobodyHome.png',
    'images/Delivery.png',
  ];

  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.1,
          bottom: MediaQuery.of(context).size.height * 0.1),
      child: Column(
        children: [
          const Text('Aaganwadi India',
          textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Gilroy',
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                  ),
                  ),

                SizedBox(height:5.0 ),
                  const Text('Empowering Communities',
          textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Gilroy',
                  fontSize: 25.0,
                  fontWeight: FontWeight.w200,
                  color: Color(0xFF333333),
                  ),
                  ),
                  

          Container(
            child: Center(
              child: CarouselSlider(
                options: CarouselOptions(
                  initialPage: 0,
                  
                  
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 1.0,
                  onPageChanged: (value, _) {
                    setState(() {
                      _currentPage = value;
                    });
                  },
                ),
                items: imgList
                    .map((item) => Center(
                          child: Image.asset(
                            item,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
          SizedBox(height: 30.0),
          buildCarouselIndicator(),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              },
              child: Text('Get Started'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.only(left: 50.0, right: 50.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildCarouselIndicator() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      for (int i = 0; i < imgList.length; i++)
        Container(
          width: i == _currentPage ? 8.0 : 5.0,
          height: i == _currentPage ? 8.0 : 5.0,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: i == _currentPage ? Colors.black : Colors.grey,
          ),
        )
    ]);
  }
}
