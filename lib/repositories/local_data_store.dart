import 'package:shared_preferences/shared_preferences.dart';

const favoritesKey = 'favorites';
const searchHistoryKey = 'search_results';

class LocalDataStore {
  late final Future<SharedPreferences> _prefsPromise;

  late final SharedPreferences _prefInstance;

  LocalDataStore(this._prefsPromise);

  init() async {
    _prefInstance = await _prefsPromise;
  }

  Future<void> addFavorite(String favorite) async {
    final favorites = await getFavorites();
    favorites.add(favorite);
    await _prefInstance.setStringList(favoritesKey, favorites);
  }

  Future<void> removeFavorite(String name) async {
    final favorites = await getFavorites();
    favorites.removeWhere((favorite) => favorite == name);
    await _prefInstance.setStringList(favoritesKey, favorites);
  }

  Future<List<String>> getFavorites() async {
    final List<String> favorites =
        _prefInstance.getStringList(favoritesKey) ?? [];
    return Future.value(favorites);
  }

  Future<void> saveSearchResults(List<String> results) async {
    await _prefInstance.setStringList(searchHistoryKey, results);
  }

  Future<List<String>> getSearchResults() async {
    final searchResults = _prefInstance.getStringList(searchHistoryKey) ?? [];
    return searchResults;
  }
}
