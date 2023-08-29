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
    favorites.removeWhere((favorite) => favorite.contains(name));
    await prefs.setStringList('favorites', favorites);
  }

  List<String> getFavorites() {
    final favorites = prefs.getStringList('favorites') ?? [];
    return favorites;
  }

  Future<void> saveSearchResults(List<String> results) async {
    await prefs.setStringList('search_results', results);
  }

  List<String> getSearchResults() {
    final searchResults = prefs.getStringList('search_results') ?? [];
    return searchResults;
  }
}
