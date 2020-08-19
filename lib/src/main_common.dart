import 'package:allthenews/src/app/allthenews_app.dart';
import 'package:allthenews/src/app/app_flavors.dart';
import 'package:allthenews/src/di/injector.dart';
import 'package:allthenews/src/ui/common/theme/theme_notifier.dart';
import 'package:allthenews/src/ui/pages/presentation/presentation_notifier.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void mainCommon(Environment flavor) {
  injectDependencies(flavor);
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => inject<ThemeNotifier>()),
        ChangeNotifierProvider(create: (_) => inject<PresentationNotifier>()),
      ],
      child: AllTheNewsApp(),
    ),
  );
}