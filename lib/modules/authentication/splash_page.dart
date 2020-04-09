import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sample_app/modules/authentication/_authentication_imports.dart';
import 'package:flutter_sample_app/modules/dashboard/_dashboard_imports.dart';
import 'package:flutter_sample_app/utils/common_utils/_common_utils_imports.dart';
import 'package:flutter_sample_app/utils/constants/_constants_imports.dart';
import 'package:flutter_sample_app/utils/local_storage/_local_storage_imports.dart';
import 'package:flutter_sample_app/utils/localization/_localization_imports.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  //Common Variables
  AppTranslations appTranslations;
  ThemeData themeData;

  /// SPLASH : Initialization of variables
  void initVariables(BuildContext context) {
    appTranslations = AppTranslations.of(context);
    themeData = Theme.of(context);
  }

  /// SPLASH : State Initialization
  @override
  void initState() {
    super.initState();
    startTime();
  }

  /// SPLASH : Timer Login
  startTime() async {
    var _duration = Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }


  /// SPLASH : View Builder
  @override
  Widget build(BuildContext context) {
    initVariables(context);
    return Scaffold(
      body: Center(child: splashBody()),
    );
  }

  /// SPLASH : View body
  splashBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(IconConstants.welcomeImage,
            width: SizeConfig.get(50), height: SizeConfig.get(50)),
        SizedBox(height: SizeConfig.get(10)),
        new Text(appTranslations.text(LangConstants.appName),
            style: themeData.textTheme.display1),
        SizedBox(height: SizeConfig.get(1)),
        new Text(appTranslations.text(LangConstants.developerName),
            style: themeData.textTheme.body1)
      ],
    );
  }

  /// SPLASH : Navigation
  void navigationPage() {
    StorageManager.instance.getIsLogin().then((isLogin) {
      if (isLogin == null || isLogin == false) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => WelcomePage()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    });
  }
}
