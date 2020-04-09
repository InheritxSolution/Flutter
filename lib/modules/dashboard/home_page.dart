import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample_app/modules/authentication/_authentication_imports.dart';
import 'package:flutter_sample_app/modules/dashboard/_dashboard_imports.dart';
import 'package:flutter_sample_app/utils/constants/_constants_imports.dart';
import 'package:flutter_sample_app/utils/local_storage/_local_storage_imports.dart';
import 'package:flutter_sample_app/utils/localization/_localization_imports.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //Common Variables
  AppTranslations appTranslations;
  ThemeData themeData;

  ///  HOME PAGE : Initialization of variables
  void initVariables(BuildContext context) {
    appTranslations = AppTranslations.of(context);
    themeData = Theme.of(context);
  }

  /// HOME PAGE : State Initialization
  @override
  void initState() {
    super.initState();
  }

  /// HOME PAGE : View Builder
  @override
  Widget build(BuildContext context) {
    initVariables(context);
    return Scaffold(
        drawer: Drawer(child: drawerBody()),
        appBar: appBarBody(),
        body: homeBody());
  }

  /// HOME PAGE : AppBar
  Widget appBarBody() {
    return AppBar(title: Text(appTranslations.text(LangConstants.dashboard)));
  }

  /// HOME PAGE : View Body
  Widget homeBody() {
    return Container();
  }

  /// HOME PAGE : Drawer
  Widget drawerBody() {
    return ListView(
      padding: const EdgeInsets.all(0.0),
      children: <Widget>[
        new UserAccountsDrawerHeader(
            accountName: new Text("Kumarpalsinh Rana"),
            accountEmail: Text("kumarpalsinh25@gmail.com"),
            currentAccountPicture: Image.asset(IconConstants.appLogo)),
        new ListTile(
            leading: Icon(Icons.home),
            title: new Text(appTranslations.text(LangConstants.home)),
            onTap: () => Navigator.pop(context)),
        new ListTile(
            leading: Icon(Icons.account_circle),
            title: new Text(appTranslations.text(LangConstants.profile)),
            onTap: () => Navigator.pop(context)),
        new ListTile(
            leading: Icon(Icons.lock),
            title: new Text(appTranslations.text(LangConstants.changePassword)),
            onTap: () => openChangePassword()),
        new ListTile(
            leading: Icon(Icons.settings),
            title: new Text(appTranslations.text(LangConstants.setting)),
            onTap: () => Navigator.pop(context)),
        new ListTile(
            leading: Icon(Icons.share),
            title: new Text(appTranslations.text(LangConstants.shareApp)),
            onTap: () => Navigator.pop(context)),
        new ListTile(
            leading: Icon(Icons.info),
            title: new Text(appTranslations.text(LangConstants.aboutApp)),
            onTap: () => Navigator.pop(context)),
        new ListTile(
            leading: Icon(Icons.exit_to_app),
            title: new Text(appTranslations.text(LangConstants.logout)),
            onTap: () => logout())
      ],
    );
  }

  /// HOME PAGE : Navigation : Change Password Page
  void openChangePassword() {
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ChangePasswordPage()));
  }

  /// HOME PAGE : Navigation : Login Page
  void logout() {
    StorageManager.instance.setIsLogin(false);
    Navigator.pop(context);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => WelcomePage()));
  }
}
