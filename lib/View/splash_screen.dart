import 'dart:async';
import 'package:aaganwadi_soochna/View/getStartedPG.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    duration: const Duration(seconds: 4),
    vsync: this,
  )..repeat();

  @override
  void initState() {
   
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const GetStarted()),
      );
    });
  }
  
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedBuilder(
                  animation: controller,
                  child: Container(
                    height: 300,
                    width: 300,
                    child: const Center(
                      child: Image(image: AssetImage('images/agnr.png')),
                    ),
                  ),
                  builder: (BuildContext context, Widget? child) {
                    return Transform.scale(
                      scale: 1.0 + (controller.value * 0.5), 
                      child: child,
                    );
                  }),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
