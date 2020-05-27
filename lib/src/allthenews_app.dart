import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/ui/common/theme/theme.dart';
import 'package:allthenews/src/ui/pages/home/home_page.dart';
import 'package:flutter/material.dart';

class AllTheNewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: newsTheme,
      home: HomePage(),
      localizationsDelegates: [
        Strings.delegate,
      ],
      supportedLocales: Strings.delegate.supportedLocales,
    );
  }
}