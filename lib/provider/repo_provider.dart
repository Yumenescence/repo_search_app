import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/github_repository_api.dart';
import '../repositories/local_data_store.dart';

class RepoProvider extends ChangeNotifier {
  final TextEditingController _searchController = TextEditingController();
  late final LocalDataStore _localDataStore;

  List<String> _repos = [];
  List<String> _favoritesRepos = [];
  bool _isLoading = false;
  bool _isLoadingHistory = false;
  String titleText = 'Search History';
  String? bodyText;

  RepoProvider() {
    _isLoadingHistory = true;
  }

  TextEditingController get searchController => _searchController;
  LocalDataStore get localDataStore => _localDataStore;
  List<String> get repos => _repos;
  List<String> get favoritesRepos => _favoritesRepos;
  bool get isLoadingRepos => _isLoading;
  bool get isLoadingHistory => _isLoadingHistory;

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    _localDataStore = LocalDataStore(prefs);
    await loadFavoritesRepos();
    await loadSearchResults();
    _isLoadingHistory = false;
    notifyListeners();
  }

  Future<void> loadFavoritesRepos() async {
    _favoritesRepos = _localDataStore.getFavorites();
  }

//Loading found repositories from the last search
  Future<void> loadSearchResults() async {
    _repos = _localDataStore.getSearchResults();
    bodyText = _repos.isEmpty
        ? 'You have an empty history.\nClick on search to start your journey!'
        : null;
  }

  Future<void> searchRepositories() async {
    _setLoading(true);
    _repos = await getRepositoriesByName(_searchController.text);
    titleText = 'What we have found';
    bodyText = _repos.isEmpty
        ? 'Nothing was found for your search.\nPlease check the spelling.'
        : null;
    await localDataStore.saveSearchResults(_repos);
    _setLoading(false);
  }

  void updateFavoritesAndNotify(String favorite) async {
    bool isFavoriteExists = _favoritesRepos.contains(favorite);

    if (isFavoriteExists) {
      _favoritesRepos.remove(favorite);
      await localDataStore.removeFavorite(favorite);
    } else {
      _favoritesRepos.add(favorite);
      await localDataStore.addFavorite(favorite);
    }

    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
