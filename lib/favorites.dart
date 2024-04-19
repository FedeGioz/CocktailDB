import 'package:shared_preferences/shared_preferences.dart';

class Favorites {
  static const _key = 'favoriteCocktails';

  static final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static Future<Set<String>> getFavorites() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getStringList(_key)?.toSet() ?? {};
  }

  static Future<bool> isFavorite(String id) async {
    Set<String> favorites = await getFavorites();
    return favorites.contains(id);
  }

  static Future<void> addFavorite(String id) async {
    final SharedPreferences prefs = await _prefs;
    Set<String> favorites = await getFavorites();
    favorites.add(id);
    await prefs.setStringList(_key, favorites.toList());
  }

  static Future<void> removeFavorite(String id) async {
    final SharedPreferences prefs = await _prefs;
    Set<String> favorites = await getFavorites();
    favorites.remove(id);
    await prefs.setStringList(_key, favorites.toList());
  }
}