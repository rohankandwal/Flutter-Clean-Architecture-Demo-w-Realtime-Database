import 'package:shared_preferences/shared_preferences.dart';

/// Class containing 'SharedPreferences' instance, all data will be
/// stored/read using this class
class MySharedPref {

  final SharedPreferences _pref;

  MySharedPref(this._pref);

}