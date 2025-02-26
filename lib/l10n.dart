import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {'title': 'Florogenix', 'settings': 'Settings', 'language': 'Language'},
    'hi': {'title': 'फ्लोरोजेनिक्स', 'settings': 'सेटिंग्स', 'language': 'भाषा'},
    'ta': {'title': 'ஃப்ளோரோஜெனிக்ஸ்', 'settings': 'அமைப்புகள்', 'language': 'மொழி'},
    'te': {'title': 'ఫ్లోరోజెనిక్స్', 'settings': 'సెట్టింగ్‌లు', 'language': 'భాష'},
    'mr': {'title': 'फ्लोरोजेनिक्स', 'settings': 'सेटिंग्स', 'language': 'भाषा'},
    'bn': {'title': 'ফ্লোরোজেনিক্স', 'settings': 'সেটিংস', 'language': 'ভাষা'},
    'gu': {'title': 'ફ્લોરોજનિક્સ', 'settings': 'સેટિંગ્સ', 'language': 'ભાષા'},
    'kn': {'title': 'ಫ್ಲೋರೋಜೆನಿಕ್ಸ್', 'settings': 'ಸೆಟ್ಟಿಂಗ್‌ಗಳು', 'language': 'ಭಾಷೆ'},
    'ml': {'title': 'ഫ്ലോറോജെനിക്സ്', 'settings': 'ക്രമീകരണം', 'language': 'ഭാഷ'},
    'ur': {'title': 'فلاوروجینکس', 'settings': 'ترتیبات', 'language': 'زبان'},
    'or': {'title': 'ଫ୍ଲୋରୋଜେନିକ୍ସ', 'settings': 'ସେଟିଂସ୍', 'language': 'ଭାଷା'},
    'pa': {'title': 'ਫਲੋਰੋਜੈਨਿਕਸ', 'settings': 'ਸੈਟਿੰਗਜ਼', 'language': 'ਭਾਸ਼ਾ'},
    'as': {'title': 'ফ্লোৰোজেনিক্স', 'settings': 'ছেটিংচ', 'language': 'ভাষা'},
    'ne': {'title': 'फ्लोरोजेनिक्स', 'settings': 'सेटिङ्हरू', 'language': 'भाषा'},
    'kok': {'title': 'फ्लोरोजेनिक्स', 'settings': 'सेटिंग्ज', 'language': 'भाषा'},
  };

  String get title => _localizedValues[locale.languageCode]!['title']!;
  String get settings => _localizedValues[locale.languageCode]!['settings']!;
  String get language => _localizedValues[locale.languageCode]!['language']!;
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      AppLocalizations._localizedValues.keys.contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
