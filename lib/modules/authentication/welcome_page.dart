import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample_app/modules/authentication/_authentication_imports.dart';
import 'package:flutter_sample_app/utils/common_utils/_common_utils_imports.dart';
import 'package:flutter_sample_app/utils/constants/_constants_imports.dart';
import 'package:flutter_sample_app/utils/localization/_localization_imports.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  //Common Variables
  AppTranslations appTranslations;
  ThemeData themeData;

  ///  WELCOME : Initialization of variables
  void initVariables(BuildContext context) {
    appTranslations = AppTranslations.of(context);
    themeData = Theme.of(context);
  }

  /// WELCOME : State Initialization
  @override
  void initState() {
    super.initState();
  }

  /// WELCOME : View Builder
  @override
  Widget build(BuildContext context) {
    initVariables(context);
    return Scaffold(
      body: welcomeBody(),
    );
  }

  /// WELCOME : View Body
  Widget welcomeBody() {
    return SafeArea(
        child: Column(
      children: <Widget>[
        Expanded(flex: 3, child: FittedBox(child: welcomeHeader())),
        Expanded(flex: 1, child: welcomeContentBody()),
        Expanded(flex: 1, child: welcomeAuthButtonsBody()),
        Expanded(
            flex: 1,
            child: Align(
                alignment: Alignment.center, child: welcomeSocialLoginBody()))
      ],
    ));
  }

  /// WELCOME : Header
  Widget welcomeHeader() {
    return Container(
        padding: EdgeInsets.all(SizeConfig.get(5)),
        child: Image.asset(IconConstants.welcomeImage,
            width: SizeConfig.get(50), height: SizeConfig.get(50)));
  }

  /// WELCOME : Content
  Widget welcomeContentBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(appTranslations.text(LangConstants.hello),
            style: themeData.textTheme.display2),
        Text(
            appTranslations.text(LangConstants.welcomeToFlutter) +
                "\n" +
                appTranslations.text(LangConstants.developerName),
            textAlign: TextAlign.center,
            style: themeData.textTheme.body1)
      ],
    );
  }

  /// WELCOME : Auth Buttons
  Widget welcomeAuthButtonsBody() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.get(4)),
            child: RaisedButton(
              child:
                  Text(appTranslations.text(LangConstants.login).toUpperCase()),
              onPressed: () {
                openLoginScreen();
              },
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.get(4)),
            child: RaisedButton(
              textColor: Colors.black,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black, width: 1),
                  borderRadius: new BorderRadius.circular(10.0)),
              child: Text(
                  appTranslations.text(LangConstants.signUp).toUpperCase()),
              onPressed: () {
                openSignUpScreen();
              },
            ),
          ),
        ),
      ],
    );
  }

  /// WELCOME : Social Login
  Widget welcomeSocialLoginBody() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          appTranslations.text(LangConstants.orViaSocialMedia),
          style: themeData.textTheme.subtitle
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(SizeConfig.get(2)),
              child: Image.asset(IconConstants.facebook,
                  width: SizeConfig.get(10), height: SizeConfig.get(10)),
            ),
            Padding(
              padding: EdgeInsets.all(SizeConfig.get(2)),
              child: Image.asset(IconConstants.google,
                  width: SizeConfig.get(10), height: SizeConfig.get(10)),
            ),
          ],
        ),
      ],
    );
  }

  /// WELCOME : Navigation : Login Page
  void openLoginScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  /// WELCOME : Navigation : Sign Up Page
  void openSignUpScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpPage()));
  }
}
