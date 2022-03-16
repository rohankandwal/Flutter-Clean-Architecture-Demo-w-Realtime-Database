import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clean_demo/core/config/navigation.dart';
import 'package:clean_demo/core/utils/constants.dart';
import 'package:clean_demo/core/utils/routes.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigation.intentWithClearAllRoutes(context, AppRoutes.feed_screen);
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: AppColors.marigold,
        ),
      ),
    );
  }
}
