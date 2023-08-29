import 'package:shared_preferences/shared_preferences.dart';

class LocalDataStore {
  final SharedPreferences prefs;

  LocalDataStore(this.prefs);

  Future<void> addFavorite(String favorite) async {
    final favorites = prefs.getStringList('favorites') ?? [];
    favorites.add(favorite);
    await prefs.setStringList('favorites', favorites);
  }

  Future<void> removeFavorite(String name) async {
    final favorites = prefs.getStringList('favorites') ?? [];
    favorites.removeWhere((favorite) => favorite.contains('"name": $name'));
    await prefs.setStringList('favorites', favorites);
  }

  List<String> getFavorites() {
    final favorites = prefs.getStringList('favorites') ?? [];
    return favorites;
  }
}
