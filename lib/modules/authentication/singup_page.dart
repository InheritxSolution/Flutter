import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample_app/modules/dashboard/_dashboard_imports.dart';
import 'package:flutter_sample_app/utils/common_utils/_common_utils_imports.dart';
import 'package:flutter_sample_app/utils/constants/_constants_imports.dart';
import 'package:flutter_sample_app/utils/local_storage/_local_storage_imports.dart';
import 'package:flutter_sample_app/utils/localization/_localization_imports.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //Common Variables
  AppTranslations appTranslations;
  ThemeData themeData;

  //Form data management variable
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  //Focus Nodes
  FocusNode _nameFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  //Sign up Data
  String _name;
  String _email;
  String _password;

  ///  SIGN UP : Initialization of variables
  void initVariables(BuildContext context) {
    appTranslations = AppTranslations.of(context);
    themeData = Theme.of(context);
  }

  /// SIGN UP : State Initialization
  @override
  void initState() {
    super.initState();
  }

  /// SIGN UP : View Builder
  @override
  Widget build(BuildContext context) {
    initVariables(context);
    return Scaffold(
      body: signUpBody(),
    );
  }

  /// SIGN UP : View Body
  Widget signUpBody() {
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
              signUpHeader(),
              SizedBox(height: SizeConfig.get(5)),
              nameInput(),
              SizedBox(height: SizeConfig.get(5)),
              emailInput(),
              SizedBox(height: SizeConfig.get(5)),
              passwordInput(),
              SizedBox(height: SizeConfig.get(15)),
              signUpButton(),
              SizedBox(height: SizeConfig.get(5)),
              loginLabel(),
            ],
          ),
        ),
      ),
    );
  }

  /// SIGN UP : Header
  Widget signUpHeader() {
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
                new Text(appTranslations.text(LangConstants.createAccount),
                    style: themeData.textTheme.display1),
                new Text(appTranslations.text(LangConstants.signUpToContinue),
                    style: themeData.textTheme.body1)
              ],
            ),
          ],
        ),
      ],
    );
  }

  /// SIGN UP : Name Input
  Widget nameInput() {
    return TextFormField(
        focusNode: _nameFocusNode,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        validator: (value) {
          return InputValidator.validateName(appTranslations, value);
        },
        onFieldSubmitted: (value) {
          FocusScope.of(context).requestFocus(_emailFocusNode);
        },
        onSaved: (String value) {
          _name = value;
        },
        decoration: new InputDecoration(
          hintText: appTranslations.text(LangConstants.enterYourName),
          labelText: appTranslations.text(LangConstants.name),
        ));
  }

  /// SIGN UP : Email Input
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

  /// SIGN UP : Password Input
  Widget passwordInput() {
    return TextFormField(
      obscureText: true,
      focusNode: _passwordFocusNode,
      keyboardType: TextInputType.text,
      validator: (value) {
        return InputValidator.validatePassword(appTranslations, value);
      },
      textInputAction: TextInputAction.done,
      onSaved: (String value) {
        _password = value;
      },
      onFieldSubmitted: (value) {
        _validateInputs();
      },
      decoration: new InputDecoration(
        hintText: appTranslations.text(LangConstants.enterYourPassword),
        labelText: appTranslations.text(LangConstants.password),
      ),
    );
  }

  /// SIGN UP : Sign Up Button
  Widget signUpButton() {
    return RaisedButton(
      child: Text(
        appTranslations.text(LangConstants.signUp).toUpperCase(),
      ),
      onPressed: () => _validateInputs(),
    );
  }

  /// SIGN UP : Sign Up label
  Widget loginLabel() {
    return GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Text(
          appTranslations.text(LangConstants.alreadyHaveAnAccountClickHere),
          textAlign: TextAlign.center,
          style: themeData.textTheme.body1,
        ));
  }

  /// SIGN UP : Data Validation
  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      print("SIGN UP name : $_name");
      print("SIGN UP email : $_email");
      print("SIGN UP password : $_password");

      openHomeScreen();
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  /// SIGN UP : Navigation : Home Page
  void openHomeScreen() {
    StorageManager.instance.setIsLogin(true);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }
}
