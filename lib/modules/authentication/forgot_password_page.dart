import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample_app/utils/common_utils/_common_utils_imports.dart';
import 'package:flutter_sample_app/utils/constants/_constants_imports.dart';
import 'package:flutter_sample_app/utils/localization/_localization_imports.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  //Common Variables
  AppTranslations appTranslations;
  ThemeData themeData;

  //Form data management variable
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  //Focus Nodes
  FocusNode _emailFocusNode = FocusNode();

  //Forgot Password Data
  String _email;

  ///  FORGOT PASSWORD : Initialization of variables
  void initVariables(BuildContext context) {
    appTranslations = AppTranslations.of(context);
    themeData = Theme.of(context);
  }

  /// FORGOT PASSWORD : State Initialization
  @override
  void initState() {
    super.initState();
  }

  /// FORGOT PASSWORD : View Builder
  @override
  Widget build(BuildContext context) {
    initVariables(context);
    return Scaffold(
      body: forgotPasswordBody(),
    );
  }

  /// FORGOT PASSWORD : View Body
  Widget forgotPasswordBody() {
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
              forgotPasswordHeader(),
              SizedBox(height: SizeConfig.get(5)),
              emailInput(),
              SizedBox(height: SizeConfig.get(15)),
              forgotPasswordButton(),
            ],
          ),
        ),
      ),
    );
  }

  /// FORGOT PASSWORD : Header
  Widget forgotPasswordHeader() {
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
                new Text(appTranslations.text(LangConstants.resetPassword),
                    style: themeData.textTheme.display1),
                new Text(appTranslations.text(LangConstants.enterEmailToContinue),
                    style: themeData.textTheme.body1)
              ],
            ),
          ],
        ),
      ],
    );
  }

  /// FORGOT PASSWORD : Email Input
  Widget emailInput() {
    return TextFormField(
        focusNode: _emailFocusNode,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.done,
        validator: (value) {
          return InputValidator.validateEmail(appTranslations, value);
        },
        onFieldSubmitted: (value) {
          Navigator.of(context).pop();
        },
        onSaved: (String value) {
          _email = value;
        },
        decoration: new InputDecoration(
          hintText: appTranslations.text(LangConstants.enterYourEmail),
          labelText: appTranslations.text(LangConstants.email),
        ));
  }

  /// FORGOT PASSWORD : Forgot Password Button
  Widget forgotPasswordButton() {
    return RaisedButton(
      child: Text(
        appTranslations.text(LangConstants.reset).toUpperCase(),
      ),
      onPressed: () => _validateInputs(),
    );
  }

  /// FORGOT PASSWORD : Data Validation
  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      print("FORGOT PASSWORD email : $_email");
      Navigator.of(context).pop();
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
