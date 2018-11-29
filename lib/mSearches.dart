import 'package:shared_preferences/shared_preferences.dart';

const SEARCHES_KEY = "searches";

class MSearchs {
  List<String> items;

  Future<Null> add(String keyword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> searches = prefs.getStringList(SEARCHES_KEY) ?? [];
    searches.removeWhere((search) => search == keyword);
    searches.add(keyword);
    prefs.setStringList(SEARCHES_KEY, searches.reversed.toList());
  }

  Future<List<String>> get() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(SEARCHES_KEY) ?? [];
  }

  Future<Null> del(String keyword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> searches = prefs.getStringList(SEARCHES_KEY) ?? [];
    searches.removeWhere((search) => search == keyword);
    prefs.setStringList(SEARCHES_KEY, searches);
  }
}
