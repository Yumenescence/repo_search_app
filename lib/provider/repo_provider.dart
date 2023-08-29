import 'package:flutter/material.dart';
import '../api/github_repository_api.dart';
import '../repositories/local_data_store.dart';

class RepoProvider extends ChangeNotifier {
  final _gitHubClient = GitHubClient();
  late final LocalDataStore _localDataStore;

  List<String> _repos = [];
  List<String> _favoritesRepos = [];
  bool _isLoadingRepos = false;
  bool _isInitialized = false;
  String titleText = 'Search History';
  String? bodyText;

  RepoProvider({required LocalDataStore localDataStore}) {
    _localDataStore = localDataStore;
    _isInitialized = true;
  }

  LocalDataStore get localDataStore => _localDataStore;
  List<String> get repos => _repos;
  List<String> get favoritesRepos => _favoritesRepos;
  bool get isLoadingRepos => _isLoadingRepos;
  bool get isInitialized => _isInitialized;

  Future<void> initialize() async {
    await _localDataStore.init();
    await loadFavoritesRepos();
    await loadSearchResults();
    _isInitialized = false;
    notifyListeners();
  }

  Future<void> loadFavoritesRepos() async {
    _favoritesRepos = await _localDataStore.getFavorites();
  }

//Loading found repositories from the last search
  Future<void> loadSearchResults() async {
    _repos = await _localDataStore.getSearchResults();
    bodyText = _repos.isEmpty
        ? 'You have an empty history.\nClick on search to start your journey!'
        : null;
  }

  Future<void> searchRepositories(String name) async {
    _setLoading(true);
    _repos = await _gitHubClient.getRepositoriesByName(name);
    titleText = 'What we have found';
    bodyText = _repos.isEmpty
        ? 'Nothing was found for your search.\nPlease check the spelling.'
        : null;
    await localDataStore.saveSearchResults(_repos);
    _setLoading(false);
  }

  void toggleFavoriteStateForRepo(String favorite) async {
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
    _isLoadingRepos = value;
    notifyListeners();
  }
}
