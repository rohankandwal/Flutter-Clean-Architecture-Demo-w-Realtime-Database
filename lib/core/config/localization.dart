import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Localization class for loading different languages
class MyLocalizations {

  /// Getting instance of this class
  static MyLocalizations? of(BuildContext context) {
    return Localizations.of<MyLocalizations>(context, MyLocalizations);
  }

  /// Getting string from en.json
  String getString(String key) => language![key];

  /// Getting list from en.json
  List<String> getList(String key) {
    final List<String> items = new List.empty(growable: true);
    if (language![key] is List) {
      items.addAll(List<String>.from(language![key].whereType<String>()));
    }  
    return items;
  }

  /// Getting HashMap from en.json
  dynamic getMap(String key) {
    return language![key];
  }
}

Map<String, dynamic>? language;

/// Class to load the json file for strings
class MyLocalizationsDelegate extends LocalizationsDelegate<MyLocalizations> {
  const MyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en'].contains(locale.languageCode);

  @override
  Future<MyLocalizations> load(Locale locale) async {
    final String string = await rootBundle.loadString("assets/i18n/${locale.languageCode}.json");
    language = json.decode(string);
    return SynchronousFuture<MyLocalizations>(MyLocalizations());
  }

  @override
  bool shouldReload(MyLocalizationsDelegate old) => false;
}