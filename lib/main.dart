import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'modules/authentication/_authentication_imports.dart';
import 'utils/app_theme/_app_theme_imports.dart';
import 'utils/common_utils/_common_utils_imports.dart';
import 'utils/localization/_localization_imports.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppTranslationsDelegate _newLocaleDelegate;

  @override
  void initState() {
    super.initState();
    setLanguage();
  }

  void setLanguage() {
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig.init(constraints, orientation);
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter App',
            theme: MyAppTheme.lightTheme,
            darkTheme: MyAppTheme.darkTheme,
            localizationsDelegates: [
              _newLocaleDelegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en'), // English
              const Locale('hi'), // Hindi
            ],
            home: SplashPage());
      });
    });
  }
}
