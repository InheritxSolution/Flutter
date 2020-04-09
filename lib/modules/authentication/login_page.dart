import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample_app/custom_widgets/_custom_widgets_imports.dart';
import 'package:flutter_sample_app/modules/authentication/_authentication_imports.dart';
import 'package:flutter_sample_app/modules/dashboard/_dashboard_imports.dart';
import 'package:flutter_sample_app/utils/common_utils/_common_utils_imports.dart';
import 'package:flutter_sample_app/utils/constants/_constants_imports.dart';
import 'package:flutter_sample_app/utils/local_storage/_local_storage_imports.dart';
import 'package:flutter_sample_app/utils/localization/_localization_imports.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  //Common Variables
  AppTranslations appTranslations;
  ThemeData themeData;

  //Form data management variable
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  //Focus Nodes
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  //Login Data
  String _email;
  String _password;

  ///  LOGIN : Initialization of variables
  void initVariables(BuildContext context) {
    appTranslations = AppTranslations.of(context);
    themeData = Theme.of(context);
  }

  /// LOGIN : State Initialization
  @override
  void initState() {
    super.initState();
  }

  /// LOGIN : View Builder
  @override
  Widget build(BuildContext context) {
    initVariables(context);
    return Scaffold(
      body: loginBody(),
    );
  }

  /// LOGIN : View Body
  Widget loginBody() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(SizeConfig.get(5)),
        child: Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(height: SizeConfig.get(5)),
              loginHeader(),
              SizedBox(height: SizeConfig.get(5)),
              emailInput(),
              SizedBox(height: SizeConfig.get(5)),
              passwordInput(),
              SizedBox(height: SizeConfig.get(15)),
              loginButton(),
              SizedBox(height: SizeConfig.get(5)),
              forgotPasswordLabel(),
              SizedBox(height: SizeConfig.get(5)),
              socialLogin(),
              SizedBox(height: SizeConfig.get(5)),
              singUpLabel()
            ],
          ),
        ),
      ),
    );
  }

  /// LOGIN : Header
  Widget loginHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
            onTap: () => Navigator.pop(context), child: Icon(Icons.arrow_back)),
        SizedBox(height: SizeConfig.get(5)),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(appTranslations.text(LangConstants.welcomeBack),
                    style: themeData.textTheme.display1),
                new Text(appTranslations.text(LangConstants.signInToContinue),
                    style: themeData.textTheme.body1)
              ],
            ),
          ],
        ),
      ],
    );
  }

  /// LOGIN : Email Input
  Widget emailInput() {
    return TextFormField(
        focusNode: _emailFocusNode,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        validator: (value) {
          return InputValidator.validateEmail(appTranslations, value);
        },
        onFieldSubmitted: (value) {
          FocusScope.of(context).requestFocus(_passwordFocusNode);
        },
        onSaved: (String value) {
          _email = value;
        },
        decoration: new InputDecoration(
          hintText: appTranslations.text(LangConstants.enterYourEmail),
          labelText: appTranslations.text(LangConstants.email),
        ));
  }

  /// LOGIN : Password Input
  Widget passwordInput() {
    return TextFormField(
      obscureText: true,
      focusNode: _passwordFocusNode,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      validator: (value) {
        return InputValidator.validatePassword(appTranslations, value);
      },
      onFieldSubmitted: (value) {
        _validateInputs();
      },
      onSaved: (String value) {
        _password = value;
      },
      decoration: new InputDecoration(
        hintText: appTranslations.text(LangConstants.enterYourPassword),
        labelText: appTranslations.text(LangConstants.password),
      ),
    );
  }

  /// LOGIN : Forgot Password Label
  Widget forgotPasswordLabel() {
    return GestureDetector(
        onTap: () {
          openForgotPasswordScreen();
        },
        child: Text(appTranslations.text(LangConstants.forgotPassword) + "?",
            textAlign: TextAlign.center, style: themeData.textTheme.body1));
  }

  /// LOGIN : Login Button
  Widget loginButton() {
    return RaisedButton(
      child: Text(appTranslations.text(LangConstants.login).toUpperCase()),
      onPressed: () => _validateInputs(),
    );
  }

  /// LOGIN : Social Login
  Widget socialLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.all(SizeConfig.get(2)),
            child: Image.asset(IconConstants.facebook,
                width: SizeConfig.get(10), height: SizeConfig.get(10))),
        Padding(
            padding: EdgeInsets.all(SizeConfig.get(2)),
            child: Image.asset(IconConstants.google,
                width: SizeConfig.get(10), height: SizeConfig.get(10))),
      ],
    );
  }

  /// LOGIN : Sign Up label
  Widget singUpLabel() {
    return GestureDetector(
        onTap: () {
          openSignUpScreen();
        },
        child: Text(
            appTranslations.text(LangConstants.doNotHaveAnAccountClickHere),
            textAlign: TextAlign.center,
            style: themeData.textTheme.body1));
  }

  /// LOGIN : Custom Dialog
  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
          title: "Success",
          description:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
          buttonText: "Okay"),
    );
  }

  /// LOGIN : Data Validation
  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      print("LOGIN email : $_email");
      print("LOGIN password : $_password");

      openHomeScreen();
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  /// LOGIN : Navigation : Home Page
  void openHomeScreen() {
    StorageManager.instance.setIsLogin(true);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  /// LOGIN : Navigation : Sign Up Page
  void openSignUpScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpPage()));
  }

  /// LOGIN : Navigation : Forgot Password Page
  void openForgotPasswordScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
  }
}
