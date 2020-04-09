import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample_app/utils/common_utils/_common_utils_imports.dart';
import 'package:flutter_sample_app/utils/constants/_constants_imports.dart';
import 'package:flutter_sample_app/utils/localization/_localization_imports.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  //Common Variables
  AppTranslations appTranslations;
  ThemeData themeData;

  //Form data management variable
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  //Focus Nodes
  FocusNode _oldPasswordFocusNode = FocusNode();
  FocusNode _newPasswordFocusNode = FocusNode();
  FocusNode _confirmPasswordFocusNode = FocusNode();

  //Text Editing Controller
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  //Change Password Data
  String _oldPassword;
  String _newPassword;
  String _confirmPassword;

  ///  CHANGE PASSWORD : Initialization of variables
  void initVariables(BuildContext context) {
    appTranslations = AppTranslations.of(context);
    themeData = Theme.of(context);
  }

  /// CHANGE PASSWORD : State Initialization
  @override
  void initState() {
    super.initState();
  }

  /// CHANGE PASSWORD : View Builder
  @override
  Widget build(BuildContext context) {
    initVariables(context);
    return Scaffold(
      body: changePasswordBody(),
    );
  }

  /// CHANGE PASSWORD : View Body
  Widget changePasswordBody() {
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
              changePasswordHeader(),
              SizedBox(height: SizeConfig.get(5)),
              oldPasswordInput(),
              SizedBox(height: SizeConfig.get(5)),
              newPasswordInput(),
              SizedBox(height: SizeConfig.get(5)),
              confirmPasswordInput(),
              SizedBox(height: SizeConfig.get(15)),
              changePasswordButton()
            ],
          ),
        ),
      ),
    );
  }

  /// CHANGE PASSWORD : Header
  Widget changePasswordHeader() {
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
                new Text(appTranslations.text(LangConstants.changePassword),
                    style: themeData.textTheme.display1),
                new Text(
                    appTranslations
                        .text(LangConstants.verifyPasswordToContinue),
                    style: themeData.textTheme.body1)
              ],
            ),
          ],
        ),
      ],
    );
  }

  /// CHANGE PASSWORD : Old Password Input
  Widget oldPasswordInput() {
    return TextFormField(
      obscureText: true,
      focusNode: _oldPasswordFocusNode,
      controller: _oldPasswordController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      validator: (value) {
        return InputValidator.validateOldPassword(appTranslations, value);
      },
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_newPasswordFocusNode);
      },
      onSaved: (String value) {
        _oldPassword = value;
      },
      decoration: new InputDecoration(
        hintText: appTranslations.text(LangConstants.enterYourOldPassword),
        labelText: appTranslations.text(LangConstants.oldPassword),
      ),
    );
  }

  /// CHANGE PASSWORD : New Password Input
  Widget newPasswordInput() {
    return TextFormField(
      obscureText: true,
      focusNode: _newPasswordFocusNode,
      controller: _newPasswordController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      validator: (value) {
        return InputValidator.validateNewPassword(appTranslations, value);
      },
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_confirmPasswordFocusNode);
      },
      onSaved: (String value) {
        _newPassword = value;
      },
      decoration: new InputDecoration(
        hintText: appTranslations.text(LangConstants.enterYourNewPassword),
        labelText: appTranslations.text(LangConstants.newPassword),
      ),
    );
  }

  /// CHANGE PASSWORD : Confirm Password Input
  Widget confirmPasswordInput() {
    return TextFormField(
      obscureText: true,
      focusNode: _confirmPasswordFocusNode,
      controller: _confirmPasswordController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      validator: (value) {
        return InputValidator.validateConfirmPassword(appTranslations,
            _newPasswordController.text, _confirmPasswordController.text);
      },
      onFieldSubmitted: (value) {
        _validateInputs();
      },
      onSaved: (String value) {
        _confirmPassword = value;
      },
      decoration: new InputDecoration(
        hintText: appTranslations.text(LangConstants.confirmYourNewPassword),
        labelText: appTranslations.text(LangConstants.confirmPassword),
      ),
    );
  }

  /// CHANGE PASSWORD : Change password Button
  Widget changePasswordButton() {
    return RaisedButton(
      child: Text(appTranslations.text(LangConstants.submit).toUpperCase()),
      onPressed: () => _validateInputs(),
    );
  }

  /// CHANGE PASSWORD : Data Validation
  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      print("CHANGE PASSWORD oldPassword : $_oldPassword");
      print("CHANGE PASSWORD newPassword : $_newPassword");
      print("CHANGE PASSWORD confirmPassword : $_confirmPassword");

      Navigator.pop(context);

    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
